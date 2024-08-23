import 'dart:io';

import 'package:musicalization/utils/showWarnDialog.dart';

class FileRenamer{
  void renameFile(String filePath, String newFileName){
    File file = File(filePath);

    try{
      _changeFileNameOnly(file, newFileName);
    }
    catch(e){
      showWarnDialog("ファイル名の変更に失敗しました。\n$e");
    }
  }

  Future<File> _changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}
