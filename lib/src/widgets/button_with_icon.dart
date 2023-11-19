import 'package:flutter/material.dart';

/// An utility widget to show an icon as trailing to a Text Button
/// Used for showing the current selected language button.
class ButtonWithTrailingIcon extends StatefulWidget {
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
  State<ButtonWithTrailingIcon> createState() => _ButtonWithTrailingIconState();
}

class _ButtonWithTrailingIconState extends State<ButtonWithTrailingIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: InkWell(
        onTap: widget.onTap,
        onHover: (hoverState) => setState(
          () => isHovered = hoverState,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                isHovered ? Theme.of(context).hoverColor : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.text, style: Theme.of(context).textTheme.bodySmall),
                widget.icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
