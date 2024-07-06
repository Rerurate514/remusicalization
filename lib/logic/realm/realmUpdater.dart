import 'package:musicalization/logic/fileFetcher.dart';
import 'package:musicalization/logic/musicCreater.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/utils/getNamesFromMusic.dart';

class Updater{
  final _io = RealmIOManager(Music.schema);
  final _fetcher = FileFetcher();
  final _creater = MusicCreater();

  void update(){
    final List<Music> originalList = _io.readAll<Music>();
    final listFromDir = _creater.generateMusicList(
      _fetcher.pathList, _fetcher.nameList
    );
    final List<Music> newList = _createUnDuplicateList(
      listFromDir, 
      originalList
    );
  
    newList.forEach((Music music) async {
      _io.update(newData: music);
    });
  }
  
  List<Music> _createUnDuplicateList(List<Music> newList, List<Music> originalList){
    final List<String> nNamesList = newList.getNamesFromMusic();
    final List<String> oNamesList = originalList.getNamesFromMusic();

    List<Music> createdList = originalList;

    for(int i = 0; i < newList.length; i++){
      if(oNamesList.contains(newList[i].name)) continue;
      createdList.add(newList[i]);
    }

    for(int i = 0; i < originalList.length; i++){
      if(nNamesList.contains(originalList[i].name)) continue;
      createdList.remove(originalList[i]);
    }

    return createdList;
  }
}