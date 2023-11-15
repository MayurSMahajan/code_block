import 'dart:developer';
import 'dart:io';
import 'package:appflowy_code_block/src/service/actions_service.dart';
import 'package:appflowy_code_block/src/utils/file_handling/file_picker_impl.dart';
import 'package:appflowy_code_block/src/utils/languages/extensions.dart';
import 'package:file_picker/file_picker.dart';

/// A service class responsible for facilitating downloading and uploading
/// programs to codeblock.
///
/// Parameters:
/// 1. `programFilePicker` a File Picker wrapper for IO operations.
/// 2. `actionsService` for mutating the state of the Codeblock.
class UploadDownloadService {
  UploadDownloadService({
    required this.programFilePicker,
    required this.actionsService,
  });

  final ProgramFilePicker programFilePicker;
  final ActionsService actionsService;

  /// Downloads the source code written inside the codeblock
  /// and saves it in local storage.
  /// Parameters:
  /// `fileName`: string, if not empty this specifies the name of the
  /// file which will be stored locally.
  Future<void> downloadProgram(String fileName) async {
    final extension = supportedExtensions[actionsService.language] ?? 'txt';
    final path = await programFilePicker.getDirectoryPath();
    if (path == null) {
      return;
    }
    final name = fileName.isEmpty ? 'codeblock' : fileName;
    final file = File('$path/$name.$extension');
    final content =
        actionsService.node.delta?.toPlainText() ?? 'Some Problem Occured';
    await file.writeAsString(content);
  }

  /// Copies all the source code inside the Codeblock and creates a new
  /// file in local storage with this code.
  Future<void> uploadProgram() async {
    final pickedFile = await programFilePicker.pickFiles(
      allowedExtensions: allExtensions,
      allowMultiple: false,
    );
    if (pickedFile == null) return;

    try {
      PlatformFile platformFile = pickedFile.files.first;
      final file = File('${platformFile.path}');
      // Read the file
      final contents = await file.readAsString();
      if (contents.isNotEmpty) {
        await actionsService.uploadCode(contents);
      }
    } catch (e) {
      log('Error Occured: ', error: e);
    }
  }
}
