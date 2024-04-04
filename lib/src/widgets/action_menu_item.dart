import 'package:flutter/material.dart';

/// An utility widget to show an icon button with hover effect
/// Used in the action menu container.
class ActionMenuIconBtn extends StatefulWidget {
  const ActionMenuIconBtn({
    required this.onTap,
    required this.icon,
    this.text = '',
    super.key,
  });

  final VoidCallback onTap;
  final Icon icon;
  final String text;

  @override
  State<ActionMenuIconBtn> createState() => _ActionMenuIconBtnState();
}

class _ActionMenuIconBtnState extends State<ActionMenuIconBtn> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
          child: Tooltip(
            message: widget.text,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.icon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
