import 'package:appflowy_code_block/src/utils/themes/code_block_style.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/widgets/widgets.dart';

/// `CodeBlockComponentBuilder` is the widget builder which implements the
/// `BlockComponentBuilder` interface for building the flutter widget
/// for the Codeblock
///
/// You can pass the following parameters to this class:
///
/// `editorState`: mandatory parameter,
/// this takes the current state of AppFlowyEditor
///
/// `codeblockStyle`: optional parameter,
/// this takes a background Color, selection Color and cursor Color
/// for the Codeblock
///
/// `padding`: optional parameter,
/// this takes internal EdgeInsets padding to be displayed inside codeblock.
///
class CodeBlockComponentBuilder extends BlockComponentBuilder {
  CodeBlockComponentBuilder({
    super.configuration,
    this.padding = const EdgeInsets.all(0),
    required this.editorState,
    this.codeblockStyle = const CodeBlockStyle(),
  });

  final EdgeInsets padding;
  final EditorState editorState;
  final CodeBlockStyle codeblockStyle;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return CodeBlockComponentWidget(
      key: node.key,
      editorState: editorState,
      node: node,
      configuration: configuration,
      padding: padding,
      style: codeblockStyle,
      showActions: showActions(node),
      actionBuilder: (context, state) => actionBuilder(
        blockComponentContext,
        state,
      ),
    );
  }

  @override
  bool validate(Node node) => node.delta != null;
}
