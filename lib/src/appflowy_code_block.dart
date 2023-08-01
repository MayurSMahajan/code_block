import 'package:flutter/material.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/widgets/widgets.dart';

class CodeBlockComponentBuilder extends BlockComponentBuilder {
  CodeBlockComponentBuilder({
    this.configuration = const BlockComponentConfiguration(),
    this.padding = const EdgeInsets.all(0),
    required this.editorState,
  });

  @override
  final BlockComponentConfiguration configuration;

  final EdgeInsets padding;

  final EditorState editorState;

  @override
  BlockComponentWidget build(BlockComponentContext blockComponentContext) {
    final node = blockComponentContext.node;
    return CodeBlockComponentWidget(
      key: node.key,
      editorState: editorState,
      node: node,
      configuration: configuration,
      padding: padding,
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
