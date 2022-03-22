// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pin _$PinFromJson(Map<String, dynamic> json) => Pin(
      (json['gpio'] as List<dynamic>)
          .map((e) => Gpio.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PinToJson(Pin instance) => <String, dynamic>{
      'gpio': instance.gpio,
    };
