import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/utils/utils.dart';
import 'package:flutter/material.dart';

Node codeBlockNode({
  Delta? delta,
  String? language,
}) {
  final attributes = {
    CodeBlockKeys.delta: (delta ?? Delta()).toJson(),
    CodeBlockKeys.language: language,
  };
  return Node(
    type: CodeBlockKeys.type,
    attributes: attributes,
  );
}

// defining the callout block menu item for selection
SelectionMenuItem codeBlockItem = SelectionMenuItem.node(
  name: 'Code Block',
  iconData: Icons.keyboard,
  keywords: ['code', 'codeblock'],
  nodeBuilder: (editorState) => codeBlockNode(),
  replace: (_, node) => node.delta?.isEmpty ?? false,
);
