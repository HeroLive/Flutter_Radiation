// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataModel.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RDht extends _RDht with RealmEntity, RealmObject {
  RDht(
    String tempC,
    String humi,
    String count,
  ) {
    RealmObject.set(this, 'tempC', tempC);
    RealmObject.set(this, 'humi', humi);
    RealmObject.set(this, 'count', count);
  }

  RDht._();

  @override
  String get tempC => RealmObject.get<String>(this, 'tempC') as String;
  @override
  set tempC(String value) => RealmObject.set(this, 'tempC', value);

  @override
  String get humi => RealmObject.get<String>(this, 'humi') as String;
  @override
  set humi(String value) => RealmObject.set(this, 'humi', value);

  @override
  String get count => RealmObject.get<String>(this, 'count') as String;
  @override
  set count(String value) => RealmObject.set(this, 'count', value);

  @override
  Stream<RealmObjectChanges<RDht>> get changes =>
      RealmObject.getChanges<RDht>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RDht._);
    return const SchemaObject(RDht, [
      SchemaProperty('tempC', RealmPropertyType.string),
      SchemaProperty('humi', RealmPropertyType.string),
      SchemaProperty('count', RealmPropertyType.string),
    ]);
  }
}
