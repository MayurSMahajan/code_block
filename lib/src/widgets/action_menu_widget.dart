import 'package:code_block/src/service/actions_service.dart';
import 'package:code_block/src/utils/file_handling/upload_download_service.dart';
import 'package:code_block/src/widgets/switch_language_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      children: [
        SwitchLanguageButton(actionsService: actionsService),
        Expanded(child: ActionsContainer(actionsService: actionsService)),
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
  final TextEditingController fileNameController = TextEditingController();
  bool isExpanded = false;

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
        const Spacer(flex: 1),
        SizedBox(
          width: 200,
          height: 44,
          child: TextField(
            controller: fileNameController,
            decoration: const InputDecoration(
              hintText: "helloworld.c",
            ),
          ),
        ),
        const Spacer(flex: 1),
        IconButton(
          onPressed: copyAllCode,
          icon: const FaIcon(
            FontAwesomeIcons.solidCopy,
            size: 16,
          ),
          tooltip: "Copy All",
        ),
        IconButton(
          onPressed: toggleExpanded,
          icon: FaIcon(
            isExpanded
                ? FontAwesomeIcons.chevronRight
                : FontAwesomeIcons.chevronLeft,
            size: 10,
          ),
          tooltip: isExpanded ? "Hide" : "More options",
        ),
        isExpanded
            ? OtherActionsIconButtons(
                otherActions: [
                  IconButton(
                    onPressed: downloadCode,
                    icon: const FaIcon(
                      FontAwesomeIcons.download,
                      size: 16,
                    ),
                    tooltip: "Download Code",
                  ),
                  IconButton(
                    onPressed: uploadCode,
                    icon: const FaIcon(
                      FontAwesomeIcons.fileImport,
                      size: 16,
                    ),
                    tooltip: "Import Code",
                  ),
                ],
              )
            : const SizedBox(width: 2),
      ],
    );
  }

  Future<void> copyAllCode() async {
    await widget.actionsService.copyAllCode();
  }

  Future<void> downloadCode() async {
    await uploadDownloadService.downloadProgram(fileNameController.value.text);
    //optionally could return a flag, indicating that the operation was completed
  }

  Future<void> uploadCode() async {
    await uploadDownloadService.uploadProgram();
  }

  void toggleExpanded() => setState(() => isExpanded = !isExpanded);
}

class OtherActionsIconButtons extends StatelessWidget {
  const OtherActionsIconButtons({super.key, required this.otherActions});

  final List<Widget> otherActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: otherActions,
    );
  }
}
