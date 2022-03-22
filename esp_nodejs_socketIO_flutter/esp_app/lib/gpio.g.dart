// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gpio _$GpioFromJson(Map<String, dynamic> json) => Gpio(
      json['pin'],
      json['name'],
      json['value'],
    );

Map<String, dynamic> _$GpioToJson(Gpio instance) => <String, dynamic>{
      'pin': instance.pin,
      'name': instance.name,
      'value': instance.value,
    };
