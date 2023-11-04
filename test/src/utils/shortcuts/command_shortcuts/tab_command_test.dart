import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('tab_command_test...', () {
    const tabSpace = "  ";

    group('tab to insert spaces', () {
      testWidgets('works with single line in empty codeblock', (tester) async {
        final editor = tester.editor..initializeWithCodeblock();
        await editor.startTesting();
        expect(editor.documentRootLen, 1);

        final node = editor.nodeAtPath([0]);
        expect(node, isNotNull);
        expect(node!.type, CodeBlockKeys.type);
        expect(node.delta!.toPlainText(), isEmpty);

        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );

        // press the tab key
        await editor.pressKey(
          key: LogicalKeyboardKey.tab,
        );

        await tester.pumpAndSettle();

        expect(node.delta!.toPlainText(), tabSpace);

        int multipleTabPresses = 3;

        for (int i = 0; i < multipleTabPresses; i++) {
          await editor.pressKey(
            key: LogicalKeyboardKey.tab,
          );
        }

        // we expect four tab spaces considering the one tab from earlier check.
        expect(node.delta!.toPlainText(), tabSpace * 4);

        await editor.dispose();
      });

      testWidgets('works with single line in non-empty codeblock',
          (tester) async {
        const text = "initial code line";
        final initialCodeblockDelta = Delta()..insert(text);
        final editor = tester.editor
          ..initializeWithCodeblock(
            delta: initialCodeblockDelta,
          );

        await editor.startTesting();

        final node = editor.nodeAtPath([0]);
        expect(node, isNotNull);
        expect(node!.delta!.toPlainText(), text);

        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );

        // press the tab key
        await editor.pressKey(
          key: LogicalKeyboardKey.tab,
        );

        await tester.pumpAndSettle();

        expect(node.delta!.toPlainText(), tabSpace + text);

        int multipleTabPresses = 3;

        for (int i = 0; i < multipleTabPresses; i++) {
          await editor.pressKey(
            key: LogicalKeyboardKey.tab,
          );
        }

        // we expect four tab spaces considering the one tab from earlier check.
        expect(node.delta!.toPlainText(), tabSpace * 4 + text);

        await editor.dispose();
      });
    });

    group('shift+tab to unindent', () {
      testWidgets('works with single line in empty codeblock', (tester) async {
        final editor = tester.editor..initializeWithCodeblock();
        await editor.startTesting();
        expect(editor.documentRootLen, 1);

        final node = editor.nodeAtPath([0]);
        expect(node, isNotNull);
        expect(node!.type, CodeBlockKeys.type);
        expect(node.delta!.toPlainText(), isEmpty);

        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );

        // press the tab key
        await editor.pressKey(
          key: LogicalKeyboardKey.tab,
        );

        await tester.pumpAndSettle();

        expect(node.delta!.toPlainText(), tabSpace);

        // press the shift+tab key
        await editor.pressKey(
          key: LogicalKeyboardKey.tab,
          isShiftPressed: true,
        );

        expect(node.delta!.toPlainText().isEmpty, true);

        await editor.dispose();
      });

      testWidgets('works with single line in non-empty codeblock',
          (tester) async {
        const text = "initial code line";
        final initialCodeblockDelta = Delta()..insert(text);
        final editor = tester.editor
          ..initializeWithCodeblock(
            delta: initialCodeblockDelta,
          );

        await editor.startTesting();

        final node = editor.nodeAtPath([0]);
        expect(node, isNotNull);
        expect(node!.delta!.toPlainText(), text);

        await editor.updateSelection(
          Selection.single(path: [0], startOffset: 0),
        );

        int multipleTabPresses = 3;

        for (int i = 0; i < multipleTabPresses; i++) {
          await editor.pressKey(
            key: LogicalKeyboardKey.tab,
          );
        }

        // we expect four tab spaces considering the one tab from earlier check.
        expect(node.delta!.toPlainText(), tabSpace * 3 + text);

        for (int i = 0; i < multipleTabPresses; i++) {
          await editor.pressKey(
            key: LogicalKeyboardKey.tab,
            isShiftPressed: true,
          );
        }

        expect(node.delta!.toPlainText(), text);

        await editor.dispose();
      });
    });
  });
}
