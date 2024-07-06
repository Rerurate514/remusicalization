import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:realm/realm.dart';

class RecordFetcher<SCHEMA extends RealmObject>{
  late final RealmIOManager _realmIOManager;

  RecordFetcher(SchemaObject schemaObjectArg){
    _realmIOManager = RealmIOManager(schemaObjectArg);
  }

  List<SCHEMA> getAllReacordList(){
    List<SCHEMA> result = _realmIOManager.readAll<SCHEMA>();
    return result;
  }

  SCHEMA getRecordFromId(ObjectId id){
    SCHEMA result = _realmIOManager.searchById<SCHEMA>(id: id);
    return result;
  }
}