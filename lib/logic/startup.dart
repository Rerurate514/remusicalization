import 'package:musicalization/logic/fileFetcher.dart';
import 'package:musicalization/logic/musicCreater.dart';
import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';

class StartUp{
  final _mediaAudioRequester = MediaAudioPermissionRequester();
  final _fetcher = FileFetcher();
  final _creater = MusicCreater();
  final _updater = Updater();

  void init() async {
    await _mediaAudioRequester.requestPermission();
    _refreshData();
  }


  void _refreshData() async {
    final pathList = await _fetcher.pathList;
    final nameList = await _fetcher.nameList;

    final musicList = _creater.generateMusicList(pathList, nameList);

    await _updater.update(musicList);
  } 
}
