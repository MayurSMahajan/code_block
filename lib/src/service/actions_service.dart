import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/utils/code_block_node/code_block_node.dart';

/// A service class which allows various operations to be performed on
/// Codeblock
///
/// Parameter:
/// 1. `editorState`: takes the editorState for commiting transactions on Codeblock
/// 2. `node`: The Codeblock node.
class ActionsService {
  final EditorState editorState;
  final Node node;

  ActionsService({
    required this.editorState,
    required this.node,
  });

  /// The current selected or default language of Codeblock Node.
  String? get language => node.attributes[CodeBlockKeys.language] as String?;

  /// A method for updating the language of Codeblock
  /// Parameter:
  /// 1. `language`: string, programming lanugage which will be set as
  /// the language of the Codeblock.
  Future<void> updateLanguage(String language) async {
    final transaction = editorState.transaction
      ..updateNode(
        node,
        {
          CodeBlockKeys.language: language == 'auto' ? null : language,
        },
      )
      ..afterSelection = Selection.collapsed(
        Position(
          path: node.path,
          offset: node.delta?.length ?? 0,
        ),
      );
    await editorState.apply(transaction);
  }

  /// Method for uploading code into Codeblock
  /// Used when Importing code from a file to the Codeblock
  /// Parameter:
  /// 1. `data`: string, the code to be uploaded into the codeblock.
  Future<void> uploadCode(String data) async {
    final newDelta = Delta()..insert(data);
    final transaction = editorState.transaction
      ..updateNode(
        node,
        {
          CodeBlockKeys.delta: newDelta.toJson(),
          CodeBlockKeys.language: null,
        },
      );
    await editorState.apply(transaction);
  }

  /// A method to copy all the code inside the codeblock to the clipboard.
  Future<void> copyAllCode() async {
    final text = node.delta?.toPlainText();
    if (text != null && text.isNotEmpty) {
      await AppFlowyClipboard.setData(text: text);
    }
  }
}
