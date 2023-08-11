import 'package:code_block/src/service/actions_service.dart';
import 'package:flutter/material.dart';
import 'package:appflowy_popover/appflowy_popover.dart';
import 'package:code_block/src/widgets/selectable_item_list_menu.dart';
import 'package:code_block/src/utils/utils.dart';
import 'package:flowy_infra_ui/flowy_infra_ui.dart';

class SwitchLanguageButton extends StatefulWidget {
  const SwitchLanguageButton({
    super.key,
    required this.actionsService,
  });

  final ActionsService actionsService;

  @override
  State<SwitchLanguageButton> createState() => _SwitchLanguageButtonState();
}

class _SwitchLanguageButtonState extends State<SwitchLanguageButton> {
  late PopoverController popoverController;
  String? get language => widget.actionsService.language;

  @override
  void initState() {
    popoverController = PopoverController();
    super.initState();
  }

  @override
  void dispose() {
    popoverController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxWidth = 120.0;
    return AppFlowyPopover(
      controller: popoverController,
      child: Container(
        width: maxWidth,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FlowyTextButton(
          '${language ?? 'auto'} ',
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 4.0,
          ),
          constraints: const BoxConstraints(maxWidth: maxWidth),
          fontColor: Theme.of(context).colorScheme.onBackground,
          fillColor: Colors.transparent,
          mainAxisAlignment: MainAxisAlignment.start,
          onPressed: () {},
        ),
      ),
      popupBuilder: (BuildContext context) {
        return SelectableItemListMenu(
          items: languages.map((e) => e).toList(),
          selectedIndex: languages.indexOf(language ?? 'auto'),
          onSelected: (index) {
            widget.actionsService.updateLanguage(languages[index]);
            popoverController.close();
          },
        );
      },
    );
  }
}
