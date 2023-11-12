import 'package:flutter/material.dart';

/// `CodeBlockStyle` is a class which accepts some AppFlowy specific Colors
/// to display with the Codeblock, so the codeblock goes well with AppFlowy's
/// theme.
///
class CodeBlockStyle {
  const CodeBlockStyle({
    this.background = const Color.fromRGBO(245, 245, 245, 1),
    this.cursorColor = const Color.fromARGB(255, 0, 0, 0),
    this.selectionColor = const Color.fromARGB(53, 111, 201, 231),
  });

  final Color background;
  final Color cursorColor;
  final Color selectionColor;
}
