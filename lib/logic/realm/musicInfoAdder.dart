import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:realm/realm.dart';

class MusicInfoAdder {
  final realmIOManager = RealmIOManager(Music.schema);

  void add(String pathArg, String nameArg) {
    Music info = Music(ObjectId(), nameArg, pathArg, 40, "", "");
    realmIOManager.add<Music>(newData: info);
  }
}
