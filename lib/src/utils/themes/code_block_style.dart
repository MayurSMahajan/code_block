import 'package:flutter/material.dart';

/// `CodeBlockStyle` is a class which accepts some AppFlowy specific Colors
/// to display with the Codeblock, so the codeblock goes well with AppFlowy's
/// theme.
///
class CodeBlockStyle {
  static Color lightBackground = const Color.fromRGBO(245, 245, 245, 1);
  static Color darkBackground = const Color.fromARGB(53, 46, 58, 62);
  static Color lightForeground = Colors.grey.shade300;
  static Color darkForeground = Colors.grey.shade900;
}
