import 'package:json_annotation/json_annotation.dart';
part 'geolocation.g.dart';

@JsonSerializable()
class Geolocation {
  int latitude;
  int longitude;

  Geolocation(this.latitude, this.longitude);

  factory Geolocation.fromJson(Map<String, dynamic> json) =>
      _$GeolocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeolocationToJson(this);
}
