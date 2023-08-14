import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('paste_command', () {
    testWidgets('works with multiline code', (tester) async {
      final editor = tester.editor..initializeWithCodeblock();

      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), isEmpty);

      // mock the clipboard
      const lines = 3;
      final text = List.generate(lines, (index) => 'line $index').join('\n');
      AppFlowyClipboard.mockSetData(
        AppFlowyClipboardData(
          text: text,
        ),
      );

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: 0),
      );

      // paste the text
      await editor.pressKey(
        key: LogicalKeyboardKey.keyV,
        isControlPressed: Platform.isLinux || Platform.isWindows,
        isMetaPressed: Platform.isMacOS,
      );

      await tester.pumpAndSettle();

      expect(node.delta!.toPlainText(), text);

      await editor.dispose();
    });

    testWidgets('works with single line', (tester) async {
      final editor = tester.editor..initializeWithCodeblock();

      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), isEmpty);

      // mock the clipboard
      const lines = 1;
      final text = List.generate(lines, (index) => 'line $index').join('\n');
      AppFlowyClipboard.mockSetData(
        AppFlowyClipboardData(
          text: text,
        ),
      );

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: 0),
      );

      // paste the text
      await editor.pressKey(
        key: LogicalKeyboardKey.keyV,
        isControlPressed: Platform.isLinux || Platform.isWindows,
        isMetaPressed: Platform.isMacOS,
      );

      await tester.pumpAndSettle();

      expect(node.delta!.toPlainText(), text);

      await editor.dispose();
    });
  });
}
