// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataModel.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class RDht extends _RDht with RealmEntity, RealmObject {
  RDht(
    double tempC,
    int humi,
    int count,
    int date,
  ) {
    RealmObject.set(this, 'tempC', tempC);
    RealmObject.set(this, 'humi', humi);
    RealmObject.set(this, 'count', count);
    RealmObject.set(this, 'date', date);
  }

  RDht._();

  @override
  double get tempC => RealmObject.get<double>(this, 'tempC') as double;
  @override
  set tempC(double value) => RealmObject.set(this, 'tempC', value);

  @override
  int get humi => RealmObject.get<int>(this, 'humi') as int;
  @override
  set humi(int value) => RealmObject.set(this, 'humi', value);

  @override
  int get count => RealmObject.get<int>(this, 'count') as int;
  @override
  set count(int value) => RealmObject.set(this, 'count', value);

  @override
  int get date => RealmObject.get<int>(this, 'date') as int;
  @override
  set date(int value) => RealmObject.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<RDht>> get changes =>
      RealmObject.getChanges<RDht>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(RDht._);
    return const SchemaObject(RDht, [
      SchemaProperty('tempC', RealmPropertyType.double),
      SchemaProperty('humi', RealmPropertyType.int),
      SchemaProperty('count', RealmPropertyType.int),
      SchemaProperty('date', RealmPropertyType.int),
    ]);
  }
}
