import 'package:realm/realm.dart';

part 'schema.realm.dart';

@RealmModel()
class _Music{
  @PrimaryKey()
  late ObjectId id;     //テーブルId
  late String name;     //曲名
  late String path;     //曲のパス
  late int volume;   //音量
  late String lyrics;   //歌詞
  late String picture;  //絵
}

@RealmModel()
class _PlayList{
  @PrimaryKey()
  late ObjectId id;           //テーブルId
  late String name;           //リスト名
  late List<ObjectId> list;   //MusicInfoのIDからなる曲リスト
}