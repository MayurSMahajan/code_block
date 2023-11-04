import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';

/// ignore any closing brace if already there is a closing brace after
///
/// - support
///   - desktop
///   - web
///   - mobile
///

final List<CharacterShortcutEvent> ignoreBracesInCodeblock = ['}', ']', ')']
    .map(
      (e) => CharacterShortcutEvent(
        key: ' closing braces in code block',
        character: e,
        handler: (editorState) => _ignoreKeysInCodeBlockCommandHandler(
          editorState,
          e,
        ),
      ),
    )
    .toList();

Future<bool> _ignoreKeysInCodeBlockCommandHandler(
  EditorState editorState,
  String key,
) async {
  final selection = editorState.selection;
  if (selection == null || !selection.isCollapsed) {
    return false;
  }
  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type) {
    return false;
  }

  if (node.delta != null &&
      checkIfSurroundedWithBraces(
          node.delta!.toPlainText(), key, selection.end.offset)) {
    final afterSelection = Selection.collapsed(
      Position(
        path: selection.end.path,
        offset: selection.end.offset + 1,
      ),
    );

    final transaction = editorState.transaction
      ..afterSelection = afterSelection;

    await editorState.apply(transaction);
    return true;
  }
  return false;
}

bool checkIfSurroundedWithBraces(String text, String key, int cursorIndex) {
  final List<String> textChars = text.split('');
  if (textChars[cursorIndex - 1] == getOpeningBrace(key) &&
      textChars[cursorIndex] == key) {
    return true;
  }
  return false;
}

String getOpeningBrace(String key) {
  if (key == ']') return '[';
  if (key == ')') return '(';
  return '{';
}
