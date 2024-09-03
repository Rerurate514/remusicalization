import 'package:musicalization/logic/playListConverter.dart';
import 'package:musicalization/models/schema.dart';

class WrappedPlayList extends PlayList{
  final List<Music> musicList;
  WrappedPlayList._(super.id, super.name, super.picture, this.musicList);

  static Future<WrappedPlayList> getInstance(PlayList playList) async {
    return WrappedPlayList._(
      playList.id,
      playList.name,
      playList.picture,
      await playList.list.toMusicList()
    );
  }
}
