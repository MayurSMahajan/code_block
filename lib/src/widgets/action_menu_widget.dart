import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/utils/file_handling/upload_download_service.dart';
import 'package:code_block/src/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';

import '../utils/file_handling/file_picker_impl.dart';

class ActionMenuWidget extends StatelessWidget {
  const ActionMenuWidget({
    super.key,
    required this.actionsService,
    required this.editorState,
  });

  final ActionsService actionsService;
  final EditorState editorState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SwitchLanguageButton(
            actionsService: actionsService, editorState: editorState),
        ActionsContainer(actionsService: actionsService),
      ],
    );
  }
}

class ActionsContainer extends StatefulWidget {
  const ActionsContainer({
    super.key,
    required this.actionsService,
  });

  final ActionsService actionsService;

  @override
  State<ActionsContainer> createState() => _ActionsContainerState();
}

class _ActionsContainerState extends State<ActionsContainer> {
  final programFilePicker = ProgramFilePicker();
  late UploadDownloadService uploadDownloadService;

  @override
  void initState() {
    super.initState();
    uploadDownloadService = UploadDownloadService(
      programFilePicker: programFilePicker,
      actionsService: widget.actionsService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 12),
        IconButton(
          onPressed: copyAllCode,
          icon: const Icon(
            Icons.copy_rounded,
            size: 20,
          ),
          tooltip: "Copy All",
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: downloadCode,
          icon: const Icon(
            Icons.download_outlined,
            size: 20,
          ),
          tooltip: "Download Code",
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: uploadCode,
          icon: const Icon(
            Icons.upload_file,
            size: 20,
          ),
          tooltip: "Import Code",
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  Future<void> copyAllCode() async {
    await widget.actionsService.copyAllCode();
  }

  Future<void> downloadCode() async {
    await uploadDownloadService.downloadProgram('codeblock');
    //optionally could return a flag, indicating that the operation was completed
  }

  Future<void> uploadCode() async {
    await uploadDownloadService.uploadProgram();
  }
}
