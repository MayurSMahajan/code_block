import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

const kCodeBlockName = "Code Block";

/// An utility class which stores the keys related to Codeblock.
class CodeBlockKeys {
  const CodeBlockKeys._();

  /// The type of the node
  ///
  /// The value is a String.
  static const String type = 'code';

  /// The content of a code block.
  ///
  /// The value is a String.
  static const String delta = 'delta';

  /// The language of a code block.
  ///
  /// The value is a String.
  static const String language = 'language';
}

/// Returns a CodeBlock Node.
///
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

/// defining the codeblock block menu item for selection
SelectionMenuItem codeBlockItem = SelectionMenuItem.node(
  getName: () => kCodeBlockName,
  iconData: Icons.abc,
  keywords: ['code', 'codeblock'],
  nodeBuilder: (editorState, _) => codeBlockNode(),
  replace: (_, node) => node.delta?.isEmpty ?? false,
);
