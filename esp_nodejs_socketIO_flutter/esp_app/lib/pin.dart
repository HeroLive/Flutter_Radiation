import 'package:json_annotation/json_annotation.dart';
import './gpio.dart';
part 'pin.g.dart';

@JsonSerializable()
class Pin {
  List<Gpio> gpio;

  Pin(this.gpio);

  factory Pin.fromJson(Map<String, dynamic> json) => _$PinFromJson(json);
  Map<String, dynamic> toJson() => _$PinToJson(this);
}
