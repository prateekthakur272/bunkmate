import 'package:file_picker/file_picker.dart';

Future<String?> getFilePath() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'png',
        'jpg',
        'jpeg',
      ]);
  if (result != null && result.files.isNotEmpty) {
    return result.files.first.path;
  }
  return null;
}
