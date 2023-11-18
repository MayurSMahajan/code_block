import 'package:appflowy_code_block/src/widgets/button_with_icon.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:appflowy_code_block/src/service/services.dart';
import 'package:appflowy_code_block/src/widgets/switch_language_button.dart';
import 'package:flutter/material.dart';

import '../utils/file_handling/file_picker_impl.dart';

/// Takes in the `ActionsService` and `EditorState` as parameter
/// to present an interface to perform various operations with
/// the Codeblock.
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
        ButtonWithTrailingIcon(
          onTap: copyAllCode,
          icon: const Icon(
            Icons.copy_rounded,
            size: 16,
          ),
          text: "Copy ",
        ),
        ButtonWithTrailingIcon(
          onTap: downloadCode,
          icon: const Icon(
            Icons.download_outlined,
            size: 16,
          ),
          text: "Download ",
        ),
        ButtonWithTrailingIcon(
          onTap: uploadCode,
          icon: const Icon(
            Icons.upload_file,
            size: 16,
          ),
          text: "Import Code ",
        ),
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
