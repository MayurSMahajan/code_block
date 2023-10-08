import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:code_block/src/utils/shortcuts/character_shortcuts/character_shortcuts.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  const text = 'AppFlowy is Awesome';
  group('insert_newline_command_test', () {
    testWidgets('works in empty codeblock', (tester) async {
      final editor = tester.editor..initializeWithCodeblock();
      await editor.startTesting();

      expect(editor.documentRootLen, 1);

      final node = editor.nodeAtPath([0]);
      expect(node, isNotNull);
      expect(node!.type, CodeBlockKeys.type);
      expect(node.delta!.toPlainText(), isEmpty);

      await editor.updateSelection(
        Selection.collapsed(Position(path: [0], offset: 0)),
      );

      final result = await enterInCodeBlock.execute(editor.editorState);
      expect(result, true);
      expect(
        node.delta!.toPlainText(),
        '\n',
      );

      editor.dispose();
    });

    // intial: AppFl|owy is Awesome
    // result: AppFl\nowy is Awesome
    testWidgets('works in the middle of a line', (tester) async {
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
        Selection.collapsed(Position(path: [0], offset: 5)),
      );

      final result = await enterInCodeBlock.execute(editor.editorState);
      expect(result, true);
      expect(
        node.delta!.toPlainText(),
        '${text.substring(0, 5)}\n${text.substring(5)}',
      );

      editor.dispose();
    });
  });
}
