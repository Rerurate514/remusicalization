
import 'package:musicalization/logic/fileFetcher.dart';
import 'package:musicalization/logic/realm/musicAdder.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';

class MusicUpdater {
  final fileFetcher = FileFetcher();
  final realmIOManager = RealmIOManager(Music.schema);
  final musicInfoAdder = MusicAdder();

  void updateDataBase() {
    List pathList = _getPathFileFromFetcher();
    List nameList = _getNameFileFromFetcher();
    
    realmIOManager.deleteAll<Music>();

    _addMusicToList(pathList, nameList);
  }

  List _getPathFileFromFetcher() {
    return fileFetcher.pathList;
  }

  List _getNameFileFromFetcher() {
    return fileFetcher.nameList;
  }

  void _addMusicToList(List pathList, List nameList){
    for (var i = 0; i < pathList.length; i++) {
      musicInfoAdder.add(pathList[i], nameList[i]);
    }   
  }
}
