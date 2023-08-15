import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/utils/code_block_node/code_block_node.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const language = 'dart';
  const String code = '''
  void main(){
    print("Hello World!");
  }
  ''';
  final delta = Delta()..insert(code);
  final node = codeBlockNode(language: language, delta: delta);
  final editorState = EditorState.blank();

  ActionsService buildSubject() {
    return ActionsService(editorState: editorState, node: node);
  }

  group('actions_service', () {
    test('builds properly', () {
      expect(
        buildSubject,
        returnsNormally,
      );
    });

    test('language getter works correctly', () {
      final actionsService = buildSubject();
      final getLanguage = actionsService.language;
      expect(getLanguage, language);
    });

    //TODO: Figure out a way to decouple this ActionsService inorder to test it.

    // test('update language works properly', () async {
    //   final actionsService = buildSubject();
    //   final getLanguage = actionsService.language;
    //   expect(getLanguage, language);

    //   //change lanugage to java
    //   const updatedLanguage = 'java';
    //   await actionsService.updateLanguage(updatedLanguage);

    //   final getUpdatedLanguage = actionsService.language;
    //   expect(getUpdatedLanguage, updatedLanguage);
    // });

    // test('copy all code works properly', () async {
    //   final actionsService = buildSubject();
    //   final dataBefore = await AppFlowyClipboard.getData();
    //   expect(dataBefore, isNot(code));

    //   await actionsService.copyAllCode();

    //   final dataAfter = await AppFlowyClipboard.getData();
    //   expect(dataAfter, code);
    // });
  });
}
