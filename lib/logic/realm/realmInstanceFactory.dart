import 'package:realm/realm.dart';

class RealmInstanceFactory{
  Realm createRealmInstance({required SchemaObject schema}){
    List<SchemaObject> SchemaObjects = [schema];
    LocalConfiguration config = Configuration.local(SchemaObjects);
    Realm realm = Realm(config);
    return realm;
  }
}
