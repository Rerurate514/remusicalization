import 'package:musicalization/models/schema.dart';
import 'package:realm/realm.dart';

class MusicCreater{
  Music createMusic(String path, String name) {
    Music music = Music(ObjectId(), name, path, 40, "", "");
    return music;
  }

  List<Music> generateMusicList(List<String> pathList, List<String> nameList){
    List<Music> musicList = [];
    
    for(int i = 0; i < pathList.length; i++){
      musicList.add(
        createMusic(pathList[i], nameList[i])
      );
    }

    return musicList;
  }
}
