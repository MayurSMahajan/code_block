import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';

/// press any brace key in code block to insert the closing brace as well.
///
/// - support
///   - desktop
///   - web
///   - mobile
///

final List<CharacterShortcutEvent> bracesInCodeblock = ['{', '[', '(']
    .map(
      (e) => CharacterShortcutEvent(
        key: 'braces in code block',
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
  String bracePair = '{}';
  switch (key) {
    case '[':
      bracePair = '[]';
      break;
    case '(':
      bracePair = '()';
      break;
  }

  final afterSelection = Selection.collapsed(Position(
    path: selection.end.path,
    offset: selection.end.offset + 1,
  ));

  final transaction = editorState.transaction
    ..insertText(
      node,
      selection.end.offset,
      bracePair,
    )
    ..afterSelection = afterSelection;

  await editorState.apply(transaction);
  return true;
}
