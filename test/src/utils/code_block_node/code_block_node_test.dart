import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/infra/testable_editor.dart';

void main() {
  group('codeBlockNode', () {
    group('constructur', () {
      test('works properly', () {
        expect(
          codeBlockNode,
          returnsNormally,
        );
      });

      test('initializes data members with null arguments', () {
        final testNode = codeBlockNode(delta: null);
        final expectedAttributes = {
          CodeBlockKeys.delta: [],
          CodeBlockKeys.language: null,
        };

        expect(
          testNode.delta,
          Delta(operations: []),
        );

        expect(
          testNode.attributes,
          expectedAttributes,
        );
      });

      test('initializes data members with proper values', () {
        const String kLanguage = 'dart';
        final testNode =
            codeBlockNode(delta: Delta(operations: []), language: kLanguage);
        final expectedAttributes = {
          CodeBlockKeys.delta: Delta(operations: []),
          CodeBlockKeys.language: kLanguage,
        };

        expect(
          testNode.attributes,
          expectedAttributes,
        );
      });
    });

    group('works with editor', () {
      testWidgets('gets inserted properly', (tester) async {
        final editor = tester.editor..addNode(codeBlockNode());

        await editor.startTesting();

        expect(editor.documentRootLen, 1);

        final node = editor.editorState.getNodeAtPath([0]);
        expect(node, isNotNull);
        expect(node!.type, CodeBlockKeys.type);
        expect(node.delta, isNotNull);
        expect(node.delta!.toPlainText(), isEmpty);

        await editor.dispose();
      });
    });
  });
}
