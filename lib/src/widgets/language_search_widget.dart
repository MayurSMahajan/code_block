import 'package:code_block/src/levenshtein.dart';
import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/utils/utils.dart';
import 'package:code_block/src/widgets/selectable_item_list_menu.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class LanguageSearchWidget extends StatefulWidget {
  const LanguageSearchWidget({
    required this.actionsService,
    required this.dismissCall,
    super.key,
  });

  final ActionsService actionsService;
  final VoidCallback dismissCall;

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
              onChanged: (value) => setState(() {
                query.value = value;
              }),
              onSubmitted: (value) {
                if (query.value.isNotEmpty) {
                  widget.actionsService.updateLanguage(langs.first);
                  widget.dismissCall();
                }
              },
              decoration: buildInputDecoration(context),
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
                } else {
                  langs = languages;
                }
                return SelectableItemListMenu(
                  items: langs,
                  onSelected: (value) {
                    widget.actionsService.updateLanguage(value);
                    widget.dismissCall();
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
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.shade800,
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

InputDecoration buildInputDecoration(BuildContext context) {
  return InputDecoration(
    constraints: const BoxConstraints(maxHeight: 32),
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outline,
        width: 1.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    isDense: false,
    hintText: 'search language',
    hintStyle: Theme.of(context)
        .textTheme
        .bodySmall!
        .copyWith(color: Theme.of(context).hintColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 1.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 1.0,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
  );
}
