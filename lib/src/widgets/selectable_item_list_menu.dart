import 'package:flutter/material.dart';

/// A wrapper around ListView to show a list of all available
/// programming langauges in Codeblock.
class SelectableItemListMenu extends StatelessWidget {
  const SelectableItemListMenu({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<String> items;
  final void Function(String) onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        return SelectableItem(
          item: item,
          onTap: () => onSelected(item),
        );
      },
      itemCount: items.length,
    );
  }
}

class SelectableItem extends StatelessWidget {
  const SelectableItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  final String item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton(
        onPressed: onTap,
        child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
