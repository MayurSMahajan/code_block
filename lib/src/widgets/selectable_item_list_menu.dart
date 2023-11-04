import 'package:flutter/material.dart';

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
      height: 32,
      child: TextButton(
        onPressed: onTap,
        child: Text(item),
      ),
    );
  }
}
