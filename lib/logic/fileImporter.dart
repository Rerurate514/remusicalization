import 'package:file_picker/file_picker.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/utils/showSuccessDialog.dart';
import 'package:realm/realm.dart';

class FileImporter {
  final FilePicker _picker = FilePickerIO();
  final _ioManager = RealmIOManager(Music.schema);

  Future<FilePickerResult?> _selectFile() async {
    FilePickerResult? result = await _picker.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac', 'm4a', 'm4b', 'ogg', 'flac'],
    );

    return result;
  }

  void importFileFromLocal() async {
    final FilePickerResult? files = await _selectFile();

    if (files == null) return;

    for (PlatformFile file in files.files) {
      _saveRealm(
        Music(
          ObjectId(), 
          file.name, 
          file.path ?? "", 
          40,
          "", 
          ""
        )
      );
    }

    showSuccessDialog("楽曲のインポートに成功しました。\nインポートボタンの下にあるアップデートボタンを押して同期してください。");
  }

  void _saveRealm(Music music) {
    _ioManager.add(newData: music);
  }
}
