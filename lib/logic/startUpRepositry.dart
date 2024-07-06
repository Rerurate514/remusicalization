import 'package:musicalization/logic/fileFetcher.dart';
import 'package:musicalization/logic/musicCreater.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';

class StartUpRepositry{
  final _fetcher = FileFetcher();
  final _creater = MusicCreater();
  final _updater = Updater();

  void refreshData() async {
    final pathList = await _fetcher.pathList;
    final nameList = await _fetcher.nameList;

    final musicList = _creater.generateMusicList(pathList, nameList);

    _updater.update(musicList);
  } 
}
