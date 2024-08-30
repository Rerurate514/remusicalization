import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:realm/realm.dart';

class RecordFetcher<SCHEMA extends RealmObject>{
  late final RealmIOManager _realmIOManager;

  RecordFetcher(SchemaObject schemaObjectArg){
    _realmIOManager = RealmIOManager(schemaObjectArg);
  }

  Future<List<SCHEMA>> getAllReacordList() async {
    List<SCHEMA> result = await _realmIOManager.readAll<SCHEMA>();
    return result;
  }

  Future<SCHEMA> getRecordFromId(ObjectId id) async {
    SCHEMA result = await _realmIOManager.searchById<SCHEMA>(id: id);
    return result;
  }
}