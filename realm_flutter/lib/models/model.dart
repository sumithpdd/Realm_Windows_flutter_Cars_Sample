import 'package:realm/realm.dart';

part 'model.g.dart';

@RealmModel()
class _Car {
  @PrimaryKey()
  late final int id;
  late String make;
  String? model;
  String? image;
  String? description;
  int? kilometers = 1;
  _Person? owner;
}

@RealmModel()
class _Person {
  late String name;
  int age = 18;
}
