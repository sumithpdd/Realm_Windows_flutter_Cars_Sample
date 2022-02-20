// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Car extends _Car with RealmObject {
  static var _defaultsSet = false;

  Car(
    int id,
    String make, {
    String? model,
    String? image,
    String? description,
    int? kilometers = 1,
    Person? owner,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<Car>({
        'kilometers': 1,
      });
    }
    RealmObject.set(this, 'id', id);
    this.make = make;
    this.model = model;
    this.image = image;
    this.description = description;
    this.kilometers = kilometers;
    this.owner = owner;
  }

  Car._();

  @override
  int get id => RealmObject.get<int>(this, 'id') as int;
  @override
  set id(int value) => throw RealmUnsupportedSetError();

  @override
  String get make => RealmObject.get<String>(this, 'make') as String;
  @override
  set make(String value) => RealmObject.set(this, 'make', value);

  @override
  String? get model => RealmObject.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObject.set(this, 'model', value);

  @override
  String? get image => RealmObject.get<String>(this, 'image') as String?;
  @override
  set image(String? value) => RealmObject.set(this, 'image', value);

  @override
  String? get description =>
      RealmObject.get<String>(this, 'description') as String?;
  @override
  set description(String? value) => RealmObject.set(this, 'description', value);

  @override
  int? get kilometers => RealmObject.get<int>(this, 'kilometers') as int?;
  @override
  set kilometers(int? value) => RealmObject.set(this, 'kilometers', value);

  @override
  Person? get owner => RealmObject.get<Person>(this, 'owner') as Person?;
  @override
  set owner(covariant Person? value) => RealmObject.set(this, 'owner', value);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Car._);
    return const SchemaObject(Car, [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('make', RealmPropertyType.string),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
      SchemaProperty('image', RealmPropertyType.string, optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('kilometers', RealmPropertyType.int, optional: true),
      SchemaProperty('owner', RealmPropertyType.object,
          optional: true, linkTarget: 'Person'),
    ]);
  }
}

class Person extends _Person with RealmObject {
  static var _defaultsSet = false;

  Person(
    String name, {
    int age = 18,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObject.setDefaults<Person>({
        'age': 18,
      });
    }
    this.name = name;
    this.age = age;
  }

  Person._();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  int get age => RealmObject.get<int>(this, 'age') as int;
  @override
  set age(int value) => RealmObject.set(this, 'age', value);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Person._);
    return const SchemaObject(Person, [
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('age', RealmPropertyType.int),
    ]);
  }
}
