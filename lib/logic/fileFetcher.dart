import 'dart:io';
import 'package:musicalization/utils/showWarnDialog.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'filrStrTrimer.dart';

class FileFetcher{
  Future<List<String>> get nameList async => await _getNameList();
  Future<List<String>> get pathList async => await _getPathList();

  final _trimFileStr = FileStrTrimer();

  FileFetcher(){
    _initFileFetcher();
  }

  Future<List> _initFileFetcher() async {
    return await _fetchFileFromDownloadDir();
  }

  Future<List<String>> _getNameList() async {
    final list = await _initFileFetcher();
    return _trimFileStr.convertFileNameToNameString(list);
  }

  Future<List<String>> _getPathList() async {
    final list = await _initFileFetcher();
    return _trimFileStr.convertFileNameToPathString(list);
  }

  Future<String> _getMusicPath() async {
  final homeDir = join(
    (await getApplicationDocumentsDirectory()).path.replaceAll("\\Documents", ""),
    'Music'
  );
  return homeDir;
}


  ///このメソッドは外部ストレージのオブジェクトを取得するメソッドです。
  Future<Directory> _fetchExternalDir() async {
    Directory? directory = Directory("");

    if(Platform.isWindows){
      //todo
      directory = Directory(await _getMusicPath());
      //directory =Directory("C:\\Users\\rerur\\Music");
    }
    else if(Platform.isAndroid){
      directory = Directory("/storage/emulated/0/Download/");
    }
    else if(Platform.isIOS){
      //todo
    }
    else{
      showWarnDialog("Unknown platform, Undefined logic");
    }

    return directory;
  }

  ///このメソッドは外部ストレージのdownloadディレクトリ内のファイルを取得するメソッドです。
  Future<List<FileSystemEntity>> _fetchFileFromDownloadDir() async {
    Directory dir = await _fetchExternalDir();

    List<FileSystemEntity> result = dir.listSync();

    return result;
  }
}
