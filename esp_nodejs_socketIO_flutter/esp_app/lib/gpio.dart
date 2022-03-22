import 'package:json_annotation/json_annotation.dart';
part 'gpio.g.dart';

@JsonSerializable()
class Gpio {
  dynamic pin;
  dynamic name;
  dynamic value;

  Gpio(this.pin, this.name, this.value);

  factory Gpio.fromJson(Map<String, dynamic> json) => _$GpioFromJson(json);
  Map<String, dynamic> toJson() => _$GpioToJson(this);
}
