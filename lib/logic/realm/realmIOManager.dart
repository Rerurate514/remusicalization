import 'package:musicalization/utils/Result.dart';
import 'package:musicalization/utils/showWarnDialog.dart';
import 'package:realm/realm.dart';
import 'realmInstanceFactory.dart';

class RealmIOManager {
  final realmInsFac = RealmInstanceFactory();
  final _reader = _DataReader();
  final _adder = _DataAdder();
  final _editor = _DataEditor();
  late final Realm realm;

  RealmIOManager(SchemaObject schemaObject) {
    realm = realmInsFac.createRealmInstance(schema: schemaObject);
  }

  Future<void> add<T extends RealmObject>({required T newData}) async {
    _adder.add<T>(realm: realm, newData: newData);
  }

  List<SCHEMA> readAll<SCHEMA extends RealmObject>() {
    Result results = _reader.readAll<SCHEMA>(realm: realm);
    return results.value;
  }

  SCHEMA searchById<SCHEMA extends RealmObject>({required ObjectId id}) {
    var result = _reader.searchById<SCHEMA>(realm: realm, id: id);
    return result.value;
  }

  Future<void> edit<T extends RealmObject>({required T newData}) async {
    _editor.edit<T>(realm: realm, newData: newData);
  }

  void delete<SCHEMA extends RealmObject>({required ObjectId id}) {
    var obj = searchById<SCHEMA>(id: id);
    realm.write(() => realm.delete<SCHEMA>(obj));
  }

  void deleteAll<SCHEMA extends RealmObject>() {
    realm.write(() => realm.deleteAll<SCHEMA>());
  }

  Future<void> update<T extends RealmObject>({required T newData}) async {
    _adder.updater<T>(realm: realm, newData: newData);
  }

}

class _DataReader {
  Result searchById<SCHEMA extends RealmObject>({required Realm realm, required ObjectId id}) {
    var infoResult = realm.find<SCHEMA>(id);

    late Result<SCHEMA> result;

    if (infoResult != null) {
      result = Result(
        isSucceeded: true,
        value: infoResult
      );
    } else {
      result = Result(
        isSucceeded: false,
        errorMsg: "That record is no Exists."
      );
      showWarnDialog(result.errorMsg);
    }

    return result;
  }

  Result<List<SCHEMA>> readAll<SCHEMA extends RealmObject>({required Realm realm}) {
    List<SCHEMA> infoResult = realm.all<SCHEMA>().toList();

    return Result(isSucceeded: true, value: infoResult);
  }
}

class _DataAdder {
  Future<Result> add<T extends RealmObject>({required Realm realm, required T newData}) async {
    realm.write(() => realm.add(newData));
    return Result(isSucceeded: true);
  }

  Future<Result> updater<T extends RealmObject>({required Realm realm, required T newData}) async {
    realm.write(() => realm.add(newData, update: true));
    return Result(isSucceeded: true);
  }
}

class _DataEditor {
  Future<Result> edit<T extends RealmObject>({required Realm realm, required T newData}) async {
    realm.write(() => realm.add(newData, update: true));
    return Result(isSucceeded: true);
  }
} 
