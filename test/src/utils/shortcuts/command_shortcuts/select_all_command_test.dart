import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('select_all_command_test...', () {
    testWidgets('should select nothing if codeblock is empty', (tester) async {
      final editor = tester.editor..initializeWithCodeblock();
      await editor.startTesting();
      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), isEmpty);

      final selection = Selection.single(path: [0], startOffset: 0);
      await editor.updateSelection(selection);

      // select all content
      await editor.pressKey(
        key: LogicalKeyboardKey.keyA,
        isControlPressed: Platform.isLinux || Platform.isWindows,
        isMetaPressed: Platform.isMacOS,
      );
      await tester.pumpAndSettle();

      // no change in selection is expected, since codeblock is empty
      expect(editor.editorState.selection, selection);

      await editor.dispose();
    });

    testWidgets('selects all content when single line on codeblock',
        (tester) async {
      const text = "initial code";
      final initialCodeblockDelta = Delta()..insert(text);
      final editor = tester.editor
        ..initializeWithCodeblock(
          delta: initialCodeblockDelta,
        );

      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), text);

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: text.length),
      );

      // select all content
      await editor.pressKey(
        key: LogicalKeyboardKey.keyA,
        isControlPressed: Platform.isLinux || Platform.isWindows,
        isMetaPressed: Platform.isMacOS,
      );
      await tester.pumpAndSettle();

      final selection = Selection(
        start: Position(path: [0], offset: 0),
        end: Position(path: [0], offset: text.length),
      );

      // no change in selection is expected, since codeblock is empty
      expect(editor.editorState.selection, selection);

      await editor.dispose();
    });

    testWidgets('selects all content when multiple lines on codeblock',
        (tester) async {
      const text = "initial\ncode";
      final initialCodeblockDelta = Delta()..insert(text);
      final editor = tester.editor
        ..initializeWithCodeblock(
          delta: initialCodeblockDelta,
        );

      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), text);

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: text.length),
      );

      // select all content
      await editor.pressKey(
        key: LogicalKeyboardKey.keyA,
        isControlPressed: Platform.isLinux || Platform.isWindows,
        isMetaPressed: Platform.isMacOS,
      );
      await tester.pumpAndSettle();

      final selection = Selection(
        start: Position(path: [0], offset: 0),
        end: Position(path: [0], offset: text.length),
      );

      // no change in selection is expected, since codeblock is empty
      expect(editor.editorState.selection, selection);

      await editor.dispose();
    });
  });
}
