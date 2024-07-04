import 'dart:io';
import 'package:musicalization/utils/showWarnDialog.dart';

import 'filrStrTrimer.dart';

class FileFetcher{
  late List _list = [];
  List get list => _list;

  List get nameList => _getNameList();
  List get pathList => _getPathList();

  final _trimFileStr = FileStrTrimer();

  FileFetcher(){
    _initFileFetcher();
  }

  Future<void> _initFileFetcher() async {
    await _fetchFileFromDownloadDir().then((value) => _list = value);
  }

  List _getNameList(){
    _initFileFetcher();
    return _trimFileStr.convertFileNameToNameString(_list);
  }

  List _getPathList(){
    _initFileFetcher();
    return _trimFileStr.convertFileNameToPathString(_list);
  }

  ///このメソッドは外部ストレージのオブジェクトを取得するメソッドです。
  Future<Directory> _fetchExternalDir() async {
    Directory? directory = Directory("");

    if(Platform.isWindows){
      //todo
      directory = Directory("C:\\Users\\rerur\\.pic");
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
  Future<List> _fetchFileFromDownloadDir() async {
    Directory dir = await _fetchExternalDir();

    List<FileSystemEntity> result = dir.listSync();

    return result;
  }
}