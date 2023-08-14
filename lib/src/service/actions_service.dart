import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/utils/code_block_node/code_block_node.dart';

class ActionsService {
  final EditorState editorState;
  final Node node;

  ActionsService({
    required this.editorState,
    required this.node,
  });

  String? get language => node.attributes[CodeBlockKeys.language] as String?;

  Future<void> updateLanguage(String language) async {
    final transaction = editorState.transaction
      ..updateNode(node, {
        CodeBlockKeys.language: language == 'auto' ? null : language,
      })
      ..afterSelection = Selection.collapse(
        node.path,
        node.delta?.length ?? 0,
      );
    await editorState.apply(transaction);
  }

  //TODO: Does not work
  Future<void> uploadCode(String data) async {
    // print("data:$data");
    final delta = Delta()..insert(data);
    // print("NewDelta: $delta");

    final transaction = editorState.transaction
      ..updateNode(node, {
        CodeBlockKeys.delta: delta,
      });
    await editorState.apply(transaction);
  }

  Future<void> copyAllCode() async {
    final text = node.delta?.toPlainText();
    if (text != null && text.isNotEmpty) {
      await AppFlowyClipboard.setData(text: text);
    }
  }
}
