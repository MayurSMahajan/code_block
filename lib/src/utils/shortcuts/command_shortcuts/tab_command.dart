import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/code_block.dart';
import 'package:flutter/material.dart';

/// tab to insert two spaces at the line start in code block.
///
/// - support
///   - desktop
///   - web
final CommandShortcutEvent tabToInsertSpacesInCodeBlockCommand =
    CommandShortcutEvent(
  key: 'tab to insert two spaces at the line start in code block',
  command: 'tab',
  handler: _tabToInsertSpacesInCodeBlockCommandHandler,
);

CommandShortcutEventHandler _tabToInsertSpacesInCodeBlockCommandHandler =
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
  const spaces = '  ';
  final lines = delta.toPlainText().split('\n');
  var index = 0;
  for (final line in lines) {
    if (index <= selection.endIndex &&
        selection.endIndex <= index + line.length) {
      final transaction = editorState.transaction
        ..insertText(
          node,
          index,
          spaces, // two spaces
        )
        ..afterSelection = Selection.collapsed(Position(
          path: selection.end.path,
          offset: selection.endIndex + spaces.length,
        ));
      editorState.apply(transaction);
      break;
    }
    index += line.length + 1;
  }
  return KeyEventResult.handled;
};

/// shift+tab to delete two spaces at the line start in code block if needed.
///
/// - support
///   - desktop
///   - web
final CommandShortcutEvent tabToDeleteSpacesInCodeBlockCommand =
    CommandShortcutEvent(
  key: 'shift + tab to delete two spaces at the line start in code block',
  command: 'shift+tab',
  handler: _tabToDeleteSpacesInCodeBlockCommandHandler,
);

CommandShortcutEventHandler _tabToDeleteSpacesInCodeBlockCommandHandler =
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
  const spaces = '  ';
  final lines = delta.toPlainText().split('\n');
  var index = 0;
  for (final line in lines) {
    if (index <= selection.endIndex &&
        selection.endIndex <= index + line.length) {
      if (line.startsWith(spaces)) {
        final transaction = editorState.transaction
          ..deleteText(
            node,
            index,
            spaces.length, // two spaces
          )
          ..afterSelection = Selection.collapsed(
            Position(
              path: selection.end.path,
              offset: selection.endIndex - spaces.length,
            ),
          );
        editorState.apply(transaction);
      }
      break;
    }
    index += line.length + 1;
  }
  return KeyEventResult.handled;
};
