import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
// ignore: implementation_imports
import 'package:appflowy_editor/src/infra/clipboard.dart' as clipboard;
import 'package:code_block/utils/code_block_node/code_block_node.dart';

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
  final selection = editorState.selection;
  if (selection == null || !selection.isCollapsed) {
    return KeyEventResult.ignored;
  }
  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type) {
    return KeyEventResult.ignored;
  }
  () async {
    final data = await clipboard.AppFlowyClipboard.getData();
    final text = data.text;
    if (text != null && text.isNotEmpty) {
      final transaction = editorState.transaction
        ..insertText(
          node,
          selection.end.offset,
          text,
        );

      await editorState.apply(transaction);
    }
  }();

  return KeyEventResult.handled;
};
