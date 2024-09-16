import 'package:musicalization/models/schema.dart';

extension MusicListContainsEx on List<Music> {
  bool containsAtMusic(Music music){
    for (Music ele in this) {
      if(ele.hashCode == music.hashCode) return true; 
    }
    return false;
  }
} 
