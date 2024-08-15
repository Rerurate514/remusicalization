import 'dart:io';

class FileRenamer{
  void renameFile(String filePath, String newFileName){
    File file = File(filePath);

    try{
      file.rename(newFileName);
    }
    catch(e){
      print("Failed to rename file. e => $e");
    }
  }
}
