import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'dht.g.dart';

@JsonSerializable()
class Dht {
  dynamic tempC;
  dynamic humi;

  Dht(this.tempC, this.humi);

  factory Dht.fromJson(Map<String, dynamic> json) => _$DhtFromJson(json);
  Map<String, dynamic> toJson() => _$DhtToJson(this);
}
