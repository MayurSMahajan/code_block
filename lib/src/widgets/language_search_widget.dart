import 'dart:developer';

import 'package:code_block/src/levenshtein.dart';
import 'package:code_block/src/utils/utils.dart';
import 'package:code_block/src/widgets/selectable_item_list_menu.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class LanguageSearchWidget extends StatefulWidget {
  const LanguageSearchWidget({super.key});

  @override
  State<LanguageSearchWidget> createState() => _LanguageSearchWidgetState();
}

class _LanguageSearchWidgetState extends State<LanguageSearchWidget> {
  List<String> langs = languages;
  final ValueNotifier<String> query = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 260,
      decoration: buildOverlayDecoration(context),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: TextField(
              cursorHeight: 20,
              onChanged: (value) => setState(() {
                query.value = value;
                log('Query: $query.value');
              }),
              decoration: const InputDecoration(
                constraints: BoxConstraints(
                  minHeight: 30,
                  minWidth: 120,
                  maxHeight: 34,
                  maxWidth: 120,
                ),
                border: UnderlineInputBorder(),
                hintText: 'type rust',
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ValueListenableBuilder(
              valueListenable: query,
              builder: (context, value, child) {
                if (value.isNotEmpty) {
                  langs = langs
                      .where(
                        (lang) => lang
                            .toLowerCase()
                            .contains(value.toLowerCase().toString()),
                      )
                      .sorted((a, b) => levenshtein(a, b))
                      .toList();

                  log('displayed list: $langs');
                } else {
                  langs = languages;
                }
                return SelectableItemListMenu(
                  items: langs,
                  selectedIndex: 0,
                  onSelected: (value) {
                    log('the selected: $value');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

BoxDecoration buildOverlayDecoration(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(6),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade800,
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
