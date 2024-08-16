import 'dart:io';

import 'package:musicalization/utils/showWarnDialog.dart';

class FileRenamer{
  void renameFile(String filePath, String newFileName){
    File file = File(filePath);

    try{
      file.rename(newFileName);
    }
    catch(e){
      showWarnDialog("ファイル名の変更に失敗しました。\n$e");
    }
  }
}
