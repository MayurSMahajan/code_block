import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/utils/code_block_node/code_block_node.dart';

final List<CommandShortcutEvent> navigationShortcutsInCodeblock = [
  toStartInCodeblock,
  selectTillStartInCodeblock,
  toEndInCodeblock,
  selectTillEndInCodeblock,
];

/// ctrl + v to paste text in code block.
///
/// - support
///   - desktop
///   - web
final CommandShortcutEvent toStartInCodeblock = CommandShortcutEvent(
  key: 'navigating to the start of line',
  command: 'home',
  macOSCommand: 'cmd+arrow left',
  handler: _navigateToStartInCodeBlock,
);

CommandShortcutEventHandler _navigateToStartInCodeBlock = (editorState) {
  var selection = editorState.selection;

  if (selection == null) {
    return KeyEventResult.ignored;
  }

  if (editorState.getNodesInSelection(selection).length != 1) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type || node.delta == null) {
    return KeyEventResult.ignored;
  }

  final content = node.delta!.toPlainText();
  final currentCursor = selection.start.offset;

  final contentTillCursor = content.substring(0, currentCursor);

  // get the closest newline character.
  final nearestNewline = contentTillCursor.lastIndexOf('\n') + 1;

  // make a new selection to select that point.
  editorState.selection = Selection.collapsed(Position(
    path: selection.start.path,
    offset: nearestNewline,
  ));

  return KeyEventResult.handled;
};

final CommandShortcutEvent selectTillStartInCodeblock = CommandShortcutEvent(
  key: 'selecting till start of line in codeblock',
  command: 'shift+home',
  macOSCommand: 'shift+cmd+arrow left',
  handler: _goAndSelectTillStart,
);

CommandShortcutEventHandler _goAndSelectTillStart = (editorState) {
  var selection = editorState.selection;

  if (selection == null) {
    return KeyEventResult.ignored;
  }

  if (editorState.getNodesInSelection(selection).length != 1) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type || node.delta == null) {
    return KeyEventResult.ignored;
  }

  final content = node.delta!.toPlainText();
  final currentCursor = selection.start.offset;

  final contentTillCursor = content.substring(0, currentCursor);

  // get the closest newline character.
  final nearestNewline = contentTillCursor.lastIndexOf('\n') + 1;

  // make a new selection to select that point.
  editorState.selection = Selection.single(
    path: selection.end.path,
    startOffset: nearestNewline,
    endOffset: selection.end.offset,
  );

  return KeyEventResult.handled;
};

final CommandShortcutEvent toEndInCodeblock = CommandShortcutEvent(
  key: 'navigating to the end in Codeblock',
  command: 'end',
  macOSCommand: 'cmd+arrow right',
  handler: _goToEndInCodeBlock,
);

CommandShortcutEventHandler _goToEndInCodeBlock = (editorState) {
  var selection = editorState.selection;

  if (selection == null) {
    return KeyEventResult.ignored;
  }

  if (editorState.getNodesInSelection(selection).length != 1) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type || node.delta == null) {
    return KeyEventResult.ignored;
  }

  final content = node.delta!.toPlainText();
  final currentCursor = selection.end.offset;

  final contentTillCursor = content.substring(
    currentCursor,
    content.length,
  );

  // get the closest newline character.
  final nearestNewline = contentTillCursor.indexOf('\n');
  if (nearestNewline == -1) {
    return KeyEventResult.ignored;
  }

  // make a new selection to select that point.
  editorState.selection = Selection.collapsed(Position(
    path: selection.end.path,
    offset: currentCursor + nearestNewline,
  ));

  return KeyEventResult.handled;
};

final CommandShortcutEvent selectTillEndInCodeblock = CommandShortcutEvent(
  key: 'select till end in codeblock',
  command: 'shift+end',
  macOSCommand: 'shift+cmd+arrow right',
  handler: _goAndSelectTillEnd,
);

CommandShortcutEventHandler _goAndSelectTillEnd = (editorState) {
  var selection = editorState.selection;

  if (selection == null) {
    return KeyEventResult.ignored;
  }

  if (editorState.getNodesInSelection(selection).length != 1) {
    return KeyEventResult.ignored;
  }

  final node = editorState.getNodeAtPath(selection.end.path);
  if (node == null || node.type != CodeBlockKeys.type || node.delta == null) {
    return KeyEventResult.ignored;
  }

  final content = node.delta!.toPlainText();
  final currentCursor = selection.end.offset;

  final contentTillCursor = content.substring(
    currentCursor,
    content.length,
  );

  // get the closest newline character.
  final nearestNewline = contentTillCursor.indexOf('\n');
  if (nearestNewline == -1) {
    return KeyEventResult.ignored;
  }

  // make a new selection to select that point.
  editorState.selection = Selection.single(
    path: selection.end.path,
    startOffset: currentCursor,
    endOffset: currentCursor + nearestNewline,
  );

  return KeyEventResult.handled;
};
