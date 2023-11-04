import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:appflowy_code_block/src/utils/code_block_node/code_block_node.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockAppFlowyClipboard extends Mock implements AppFlowyClipboard {}

void main() {
  const language = 'dart';
  const String code = '''
  void main(){
    print("Hello World!");
  }
  ''';

  group('actions_service', () {
    late ActionsService actionsService;
    late Delta delta;
    late Node node;
    late EditorState editorState;

    ActionsService buildSubject() {
      return ActionsService(editorState: editorState, node: node);
    }

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      delta = Delta()..insert(code);
      node = codeBlockNode(language: language, delta: delta);
      editorState = EditorState.blank();
      actionsService = buildSubject();
    });

    test('builds properly', () {
      expect(
        buildSubject,
        returnsNormally,
      );
    });

    test('language getter works correctly', () {
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

    //   late String getUpdatedLanguage;
    //   await Future.delayed(const Duration(milliseconds: 500), () {
    //     getUpdatedLanguage = node.attributes['language'];
    //   });
    //   expect(getUpdatedLanguage, updatedLanguage);
    // });

    // test('copy all code works properly', () async {
    //   // not possible to mock since these getData is a static method.
    //   // final mockClipboard = MockAppFlowyClipboard();
    //   // when(() => mockClipboard.getData()).thenAnswer((_) async => ClipboardData(text: null));

    //   final dataBefore = await AppFlowyClipboard.getData();
    //   final textInClipboardBefore = dataBefore.text;
    //   expect(textInClipboardBefore, null);

    //   final copyAllCodeFuture = actionsService.copyAllCode();

    //   // Wait for the future to complete
    //   await expectLater(copyAllCodeFuture, completes);

    //   final dataAfter = await AppFlowyClipboard.getData();
    //   final textInClipboardAfter = dataAfter.text;
    //   expect(textInClipboardAfter, code);
    // });
  });
}
