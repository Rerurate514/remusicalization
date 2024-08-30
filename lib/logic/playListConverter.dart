import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:realm/realm.dart';

extension PlaylistConverter on List<ObjectId> {
  Future<List<Music>> toMusicList() async {
    final RecordFetcher<Music> fetcher = RecordFetcher<Music>(Music.schema);

    final List<Music> musicList = [];

    for(ObjectId id in this){
      Music music = await fetcher.getRecordFromId(id);
      musicList.add(music);
    }

    return musicList;
  }
}
