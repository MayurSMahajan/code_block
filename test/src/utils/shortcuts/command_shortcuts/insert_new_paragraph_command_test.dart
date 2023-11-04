import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('insert_new_paragraph_command...', () {
    testWidgets('works with empty codeblock', (tester) async {
      final editor = tester.editor..initializeWithCodeblock();
      await editor.startTesting();

      //there is only one node on the editor and that is codeblock.
      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), isEmpty);

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: 0),
      );

      // press shift + enter
      await editor.pressKey(
        key: LogicalKeyboardKey.enter,
        isShiftPressed: true,
      );

      await tester.pumpAndSettle();

      // a new paragraph node must be inserted.
      expect(editor.documentRootLen, 2);
      final newParaNode = editor.nodeAtPath([1]);
      expect(newParaNode, isNotNull);
      expect(newParaNode!.type, ParagraphBlockKeys.type);

      await editor.dispose();
    });

    testWidgets('works with non-empty codeblock', (tester) async {
      const initialCodeblockText = "initial code";
      final initialCodeblockDelta = Delta()..insert(initialCodeblockText);
      final editor = tester.editor
        ..initializeWithCodeblock(
          delta: initialCodeblockDelta,
        );

      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), initialCodeblockText);

      await editor.updateSelection(
        Selection.single(path: [0], startOffset: initialCodeblockText.length),
      );

      // press shift + enter
      await editor.pressKey(
        key: LogicalKeyboardKey.enter,
        isShiftPressed: true,
      );

      await tester.pumpAndSettle();

      // a new paragraph node must be inserted.
      expect(editor.documentRootLen, 2);
      final newParaNode = editor.nodeAtPath([1]);
      expect(newParaNode, isNotNull);
      expect(newParaNode!.type, ParagraphBlockKeys.type);

      await editor.dispose();
    });
  });
}
