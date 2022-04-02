import 'package:realm/realm.dart';
part 'dataModel.g.dart';

@RealmModel()
class _RDht {
  late String tempC;
  late String humi;
  late String count;
}
