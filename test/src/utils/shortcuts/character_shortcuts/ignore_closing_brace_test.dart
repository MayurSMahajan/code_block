import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/infra/testable_editor.dart';

void main() {
  group('ignore closing brace ', () {
    testWidgets('curly brace', (tester) async {
      await _testClosingBraceShortcut(
        tester: tester,
        openingBrace: '{',
        closingBrace: '}',
      );
    });

    testWidgets('square brace', (tester) async {
      await _testClosingBraceShortcut(
        tester: tester,
        openingBrace: '[',
        closingBrace: ']',
      );
    });

    testWidgets('circle brace', (tester) async {
      await _testClosingBraceShortcut(
        tester: tester,
        openingBrace: '(',
        closingBrace: ')',
      );
    });
  });
}

Future<void> _testClosingBraceShortcut({
  required WidgetTester tester,
  required String openingBrace,
  required String closingBrace,
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

  // press opening brace key to insert the brace pair.
  await editor.pressKey(character: openingBrace);

  expect(node.delta!.toPlainText(), '$openingBrace$closingBrace');
  expect(editor.selection, Selection.single(path: [0], startOffset: 1));

  // again press the closing brace key
  await editor.pressKey(character: closingBrace);

  // the closing brace should be ignored and thus there should be no change.
  expect(node.delta!.toPlainText(), '$openingBrace$closingBrace');

  // also check if the cursor's position has updated.
  expect(editor.selection, Selection.single(path: [0], startOffset: 2));

  await editor.dispose();
}
