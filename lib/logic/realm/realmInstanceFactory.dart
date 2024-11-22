import 'package:realm/realm.dart';

class RealmInstanceFactory{
  Realm createRealmInstance({required SchemaObject schema}){
    List<SchemaObject> schemaObjects = [schema];
    LocalConfiguration config = Configuration.local(schemaObjects);
    Realm realm = Realm(config);
    return realm;
  }
}
