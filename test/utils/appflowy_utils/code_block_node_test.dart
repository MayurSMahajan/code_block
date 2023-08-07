import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
