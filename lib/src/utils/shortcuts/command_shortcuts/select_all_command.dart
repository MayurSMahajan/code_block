import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/appflowy_code_block.dart';
import 'package:flutter/material.dart';

/// CTRL+A to select all content inside a Code Block, if cursor is inside one.
///
/// - support
///   - desktop
///   - web
final CommandShortcutEvent selectAllInCodeBlockCommand = CommandShortcutEvent(
  key: 'ctrl + a to select all content inside a code block',
  command: 'ctrl+a',
  macOSCommand: 'meta+a',
  handler: _selectAllInCodeBlockCommandHandler,
);

CommandShortcutEventHandler _selectAllInCodeBlockCommandHandler =
    (editorState) {
  final selection = editorState.selection;
  if (selection == null || !selection.isSingle) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  final delta = node?.delta;
  if (node == null || delta == null || node.type != CodeBlockKeys.type) {
    return KeyEventResult.ignored;
  }

  editorState.service.selectionService.updateSelection(
    Selection.single(
      path: node.path,
      startOffset: 0,
      endOffset: delta.length,
    ),
  );

  return KeyEventResult.handled;
};
