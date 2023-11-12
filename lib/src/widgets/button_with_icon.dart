import 'package:flutter/material.dart';

/// An utility widget to show an icon as trailing to a Text Button
/// Used for showing the current selected language button.
class ButtonWithTrailingIcon extends StatelessWidget {
  const ButtonWithTrailingIcon({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(text),
            icon,
          ],
        ),
      ),
    );
  }
}
