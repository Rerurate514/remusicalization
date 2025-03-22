import 'dart:io';
import 'package:musicalization/utils/fetchNowOSDownloadsDir.dart';

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
    return await _trimFileStr.convertFileNameToNameString(list);
  }

  Future<List<String>> _getPathList() async {
    final list = await _initFileFetcher();
    return _trimFileStr.convertFileNameToPathString(list);
  }

  ///このメソッドは外部ストレージのdownloadディレクトリ内のファイルを取得するメソッドです。
  Future<List<FileSystemEntity>> _fetchFileFromDownloadDir() async {
    Directory dir = await fetchNowOSDownloadsDirectory();

    List<FileSystemEntity> result = dir.listSync();

    return result;
  }
}
