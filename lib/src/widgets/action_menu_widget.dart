import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/utils/file_handling/upload_download_service.dart';
import 'package:code_block/src/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';

import '../utils/file_handling/file_picker_impl.dart';

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
        IconButton(onPressed: downloadCode, icon: const Icon(Icons.download)),
      ],
    );
  }

  Future<void> copyAllCode() async {
    await actionsService.copyAllCode();
  }

  Future<void> downloadCode() async {
    final programFilePicker = ProgramFilePicker();
    final uploadDownloadService = UploadDownloadService(
      programFilePicker: programFilePicker,
    );
    await uploadDownloadService.downloadProgram(actionsService);
    //optionally could return a flag, indicating that the operation was completed
  }
}
