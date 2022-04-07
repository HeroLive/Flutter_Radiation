import 'dart:ffi';

import 'package:realm/realm.dart';
part 'dataModel.g.dart';

@RealmModel()
class _RDht {
  late double tempC;
  late int humi;
  late int count;
  late int date;
}
