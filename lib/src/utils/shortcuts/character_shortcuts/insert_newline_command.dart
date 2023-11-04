import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';

/// press the enter key in code block to insert a new line in it.
///
/// - support
///   - desktop
///   - web
///   - mobile
///
final CharacterShortcutEvent enterInCodeBlock = CharacterShortcutEvent(
  key: 'press enter in code block',
  character: '\n',
  handler: _enterInCodeBlockCommandHandler,
);

CharacterShortcutEventHandler _enterInCodeBlockCommandHandler =
    (editorState) async {
  final selection = editorState.selection;
  if (selection == null || !selection.isCollapsed) {
    return false;
  }
  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type) {
    return false;
  }
  final transaction = editorState.transaction
    ..insertText(
      node,
      selection.end.offset,
      '\n',
    );
  await editorState.apply(transaction);
  return true;
};
