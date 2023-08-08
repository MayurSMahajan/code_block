import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';

/// ignore ' ', '/', '_', '*' in code block.
///
/// - support
///   - desktop
///   - web
///   - mobile
///
final List<CharacterShortcutEvent> ignoreKeysInCodeBlock =
    [' ', '/', '_', '*', '~']
        .map(
          (e) => CharacterShortcutEvent(
            key: 'press enter in code block',
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
  await editorState.insertTextAtCurrentSelection(key);
  return true;
}
