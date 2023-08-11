import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';

class ActionMenuWidget extends StatelessWidget {
  const ActionMenuWidget({
    super.key,
    required this.actionsService,
  });

  final ActionsService actionsService;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SwitchLanguageButton(actionsService: actionsService),
        ActionsContainer(actionsService: actionsService),
      ],
    );
  }
}

class ActionsContainer extends StatelessWidget {
  const ActionsContainer({
    super.key,
    required this.actionsService,
  });

  final ActionsService actionsService;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: copyAllCode, icon: const Icon(Icons.copy_all)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.upload)),
      ],
    );
  }

  Future<void> copyAllCode() async {
    await actionsService.copyAllCode();
  }
}
