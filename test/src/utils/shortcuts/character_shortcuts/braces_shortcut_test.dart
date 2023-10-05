import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('braces_shortcut', () {
    testWidgets('curly brace in empty codeblock', (tester) async {
      await _testBraceShortcut(
        tester: tester,
        braceOpening: '{',
        expectedString: '{}',
      );
    });

    testWidgets('square brace in empty codeblock', (tester) async {
      await _testBraceShortcut(
        tester: tester,
        braceOpening: '[',
        expectedString: '[]',
      );
    });

    testWidgets('circle brace in empty codeblock', (tester) async {
      await _testBraceShortcut(
        tester: tester,
        braceOpening: '(',
        expectedString: '()',
      );
    });
  });
}

Future<void> _testBraceShortcut({
  required WidgetTester tester,
  required String braceOpening,
  required String expectedString,
}) async {
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

  // press shift + enter
  await editor.pressKey(
    character: braceOpening,
  );

  expect(node.delta!.toPlainText(), expectedString);

  await editor.dispose();
}
