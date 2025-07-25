// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
class Music extends _Music with RealmEntity, RealmObjectBase, RealmObject {
  Music(
    ObjectId id,
    String name,
    String path,
    int volume,
    String lyrics,
    String picture,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'path', path);
    RealmObjectBase.set(this, 'volume', volume);
    RealmObjectBase.set(this, 'lyrics', lyrics);
    RealmObjectBase.set(this, 'picture', picture);
  }

  Music._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get path => RealmObjectBase.get<String>(this, 'path') as String;
  @override
  set path(String value) => RealmObjectBase.set(this, 'path', value);

  @override
  int get volume => RealmObjectBase.get<int>(this, 'volume') as int;
  @override
  set volume(int value) => RealmObjectBase.set(this, 'volume', value);

  @override
  String get lyrics => RealmObjectBase.get<String>(this, 'lyrics') as String;
  @override
  set lyrics(String value) => RealmObjectBase.set(this, 'lyrics', value);

  @override
  String get picture => RealmObjectBase.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => RealmObjectBase.set(this, 'picture', value);

  @override
  Stream<RealmObjectChanges<Music>> get changes =>
      RealmObjectBase.getChanges<Music>(this);

  @override
  Stream<RealmObjectChanges<Music>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Music>(this, keyPaths);

  @override
  Music freeze() => RealmObjectBase.freezeObject<Music>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'path': path.toEJson(),
      'volume': volume.toEJson(),
      'lyrics': lyrics.toEJson(),
      'picture': picture.toEJson(),
    };
  }

  static EJsonValue _toEJson(Music value) => value.toEJson();
  static Music _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'path': EJsonValue path,
        'volume': EJsonValue volume,
        'lyrics': EJsonValue lyrics,
        'picture': EJsonValue picture,
      } =>
        Music(
          fromEJson(id),
          fromEJson(name),
          fromEJson(path),
          fromEJson(volume),
          fromEJson(lyrics),
          fromEJson(picture),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Music._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, Music, 'Music', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('path', RealmPropertyType.string),
      SchemaProperty('volume', RealmPropertyType.int),
      SchemaProperty('lyrics', RealmPropertyType.string),
      SchemaProperty('picture', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class PlayList extends _PlayList
    with RealmEntity, RealmObjectBase, RealmObject {
  PlayList(
    ObjectId id,
    String name,
    String picture, {
    Iterable<ObjectId> list = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set<RealmList<ObjectId>>(
        this, 'list', RealmList<ObjectId>(list));
    RealmObjectBase.set(this, 'picture', picture);
  }

  PlayList._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<ObjectId> get list =>
      RealmObjectBase.get<ObjectId>(this, 'list') as RealmList<ObjectId>;
  @override
  set list(covariant RealmList<ObjectId> value) =>
      throw RealmUnsupportedSetError();

  @override
  String get picture => RealmObjectBase.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => RealmObjectBase.set(this, 'picture', value);

  @override
  Stream<RealmObjectChanges<PlayList>> get changes =>
      RealmObjectBase.getChanges<PlayList>(this);

  @override
  Stream<RealmObjectChanges<PlayList>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<PlayList>(this, keyPaths);

  @override
  PlayList freeze() => RealmObjectBase.freezeObject<PlayList>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'list': list.toEJson(),
      'picture': picture.toEJson(),
    };
  }

  static EJsonValue _toEJson(PlayList value) => value.toEJson();
  static PlayList _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'picture': EJsonValue picture,
      } =>
        PlayList(
          fromEJson(id),
          fromEJson(name),
          fromEJson(picture),
          list: fromEJson(ejson['list']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(PlayList._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(ObjectType.realmObject, PlayList, 'PlayList', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('list', RealmPropertyType.objectid,
          collectionType: RealmCollectionType.list),
      SchemaProperty('picture', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
