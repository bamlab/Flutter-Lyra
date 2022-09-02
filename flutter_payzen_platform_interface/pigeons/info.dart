import 'package:pigeon/pigeon.dart';

class Infos {
  String? info1;
  String? info2;
}

@HostApi()
// ignore: one_member_abstracts
abstract class InfosApi {
  Infos? search();
}
