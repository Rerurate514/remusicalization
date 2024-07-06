import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/utils/getNamesFromMusic.dart';

class Updater{
  final _io = RealmIOManager(Music.schema);

  void update(List<Music> newList){
    final List<Music> originalList = _io.readAll<Music>();
    final List<Music> createdList = _createUnDuplicateList(
      newList, 
      originalList
    );
  
    createdList.forEach((Music music) async {
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