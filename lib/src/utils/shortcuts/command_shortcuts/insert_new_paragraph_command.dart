import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/material.dart';

/// shift + enter to insert a new node next to the code block.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent insertNewParagraphNextToCodeBlockCommand =
    CommandShortcutEvent(
  key: 'insert a new paragraph next to the code block',
  command: 'shift+enter',
  handler: _insertNewParagraphNextToCodeBlockCommandHandler,
);

CommandShortcutEventHandler _insertNewParagraphNextToCodeBlockCommandHandler =
    (editorState) {
  final selection = editorState.selection;
  if (selection == null || !selection.isCollapsed) {
    return KeyEventResult.ignored;
  }
  final node = editorState.getNodeAtPath(selection.end.path);
  final delta = node?.delta;
  if (node == null || delta == null || node.type != CodeBlockKeys.type) {
    return KeyEventResult.ignored;
  }
  final sliced = delta.slice(selection.startIndex);
  final transaction = editorState.transaction
    ..deleteText(
      // delete the text after the cursor in the code block
      node,
      selection.startIndex,
      delta.length - selection.startIndex,
    )
    ..insertNode(
      // insert a new paragraph node with the sliced delta after the code block
      selection.end.path.next,
      paragraphNode(
        attributes: {
          'delta': sliced.toJson(),
        },
      ),
    )
    ..afterSelection = Selection.collapsed(
      Position(
        path: selection.end.path.next,
        offset: 0,
      ),
    );
  editorState.apply(transaction);
  return KeyEventResult.handled;
};
