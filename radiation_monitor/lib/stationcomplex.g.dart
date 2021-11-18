// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stationcomplex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationComplex _$StationComplexFromJson(Map<String, dynamic> json) =>
    StationComplex(
      Station.fromJson(json['station'] as Map<String, dynamic>),
      StationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StationComplexToJson(StationComplex instance) =>
    <String, dynamic>{
      'station': instance.station.toJson(),
      'data': instance.data.toJson(),
    };
