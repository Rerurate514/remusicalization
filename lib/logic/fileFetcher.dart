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

  Future<List<FileSystemEntity>> _initFileFetcher() async {
    return await _fetchFileFromDownloadDir();
  }

  Future<List<String>> _getNameList() async {
    final list = await _initFileFetcher();
    final audioList = _filterAudioFiles(list);
    return await _trimFileStr.convertFileNameToNameString(audioList);
  }

  Future<List<String>> _getPathList() async {
    final list = await _initFileFetcher();
    final audioList = _filterAudioFiles(list);
    return _trimFileStr.convertFileNameToPathString(audioList);
  }

  ///このメソッドは外部ストレージのdownloadディレクトリ内のファイルを取得するメソッドです。
  Future<List<FileSystemEntity>> _fetchFileFromDownloadDir() async {
    Directory dir = await fetchNowOSDownloadsDirectory();

    List<FileSystemEntity> result = dir.listSync();

    return result;
  }

  List<FileSystemEntity> _filterAudioFiles(List<FileSystemEntity> list){
    return list.where((file) => 
      file.path.endsWith(".mp3") ||
      file.path.endsWith(".wav") ||
      file.path.endsWith(".aac") ||
      file.path.endsWith(".m4a") ||
      file.path.endsWith(".m4b") ||
      file.path.endsWith(".ogg") ||
      file.path.endsWith(".flac")
    ).toList();
  }
}
