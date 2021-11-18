import 'package:json_annotation/json_annotation.dart';
part 'stationdata.g.dart';

@JsonSerializable()
class StationData {
  StationData(this.tempC, this.humi, this.uSv, this.cps, this.counts,
      this.statusStation, this.date, this.realtime, this.id);

  String tempC;
  dynamic humi;
  String uSv;
  int cps;
  dynamic counts;
  String statusStation;
  String date;
  int realtime;
  String id;
  static final StationData _default =
      StationData('', '', '', 0, 0, '', '', 0, '');
  factory StationData.empty() {
    return _default;
  }

  factory StationData.fromJson(Map<String, dynamic> json) =>
      _$StationDataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$StationDataToJson(this);
}
