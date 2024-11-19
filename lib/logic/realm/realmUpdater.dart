import 'package:musicalization/logic/fileFetcher.dart';
import 'package:musicalization/logic/musicCreater.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/utils/getNamesFromMusic.dart';
import 'package:musicalization/utils/listDifference.dart';

class Updater{
  final _io = RealmIOManager(Music.schema);
  final _fileFetcher = FileFetcher();
  final _creater = MusicCreater();

  Future<void> update() async {
    final List<Music> originalList = await _io.readAll<Music>();
    final List<Music> newList = await _fetchLocalStorage();
    final List<Music> createdList = _createUnDuplicateList(
      newList, 
      originalList 
    );

    final List<Music> listDiff = listDifference<Music>(originalList, createdList);

    createdList.forEach((Music music) async {
      _io.update<Music>(newData: music);
    });

    listDiff.forEach((Music music) async {
      print(music.name);
      _io.delete<Music>(id: music.id);
    });
  }

  Future<List<Music>> _fetchLocalStorage() async {
    final pathList = await _fileFetcher.pathList;
    final nameList = await _fileFetcher.nameList;

    final musicList = _creater.generateMusicList(pathList, nameList);
    return musicList;
  }
  
  List<Music> _createUnDuplicateList(List<Music> newList, List<Music> originalList){
    final List<String> nNamesList = newList.getNamesFromMusic();
    final List<String> oNamesList = originalList.getNamesFromMusic();

    List<Music> createdList = [...originalList];

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
