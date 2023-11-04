import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/utils/code_block_node/code_block_node.dart';

/// ctrl + v to paste text in code block.
///
/// - support
///   - desktop
///   - web
final CommandShortcutEvent pasteInCodeblock = CommandShortcutEvent(
  key: 'paste in codeblock',
  command: 'ctrl+v',
  macOSCommand: 'cmd+v',
  handler: _pasteInCodeBlock,
);

CommandShortcutEventHandler _pasteInCodeBlock = (editorState) {
  var selection = editorState.selection;

  if (selection == null) {
    return KeyEventResult.ignored;
  }

  if (editorState.getNodesInSelection(selection).length != 1) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type) {
    return KeyEventResult.ignored;
  }

  // delete the selection first.
  if (!selection.isCollapsed) {
    editorState.deleteSelection(selection);
  }

  // fetch selection again.
  selection = editorState.selection;
  if (selection == null) {
    return KeyEventResult.skipRemainingHandlers;
  }
  assert(selection.isCollapsed);

  () async {
    final data = await AppFlowyClipboard.getData();
    final text = data.text;
    if (text != null && text.isNotEmpty) {
      final transaction = editorState.transaction
        ..insertText(
          node,
          selection!.end.offset,
          text,
        );

      await editorState.apply(transaction);
    }
  }();

  return KeyEventResult.handled;
};
