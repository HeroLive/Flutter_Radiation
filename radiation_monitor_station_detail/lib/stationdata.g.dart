// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stationdata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationData _$StationDataFromJson(Map<String, dynamic> json) => StationData(
      json['tempC'] as String,
      json['humi'],
      json['uSv'] as String,
      json['cps'] as int,
      json['counts'],
      json['statusStation'] as String,
      json['date'] as String,
      json['realtime'] as int,
      json['id'] as String,
    );

Map<String, dynamic> _$StationDataToJson(StationData instance) =>
    <String, dynamic>{
      'tempC': instance.tempC,
      'humi': instance.humi,
      'uSv': instance.uSv,
      'cps': instance.cps,
      'counts': instance.counts,
      'statusStation': instance.statusStation,
      'date': instance.date,
      'realtime': instance.realtime,
      'id': instance.id,
    };
