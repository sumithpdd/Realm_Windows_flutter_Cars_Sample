// ignore_for_file: avoid_print

import 'package:realm/realm.dart';
import 'package:realm_flutter/models/dummy_data.dart';

import '../models/model.dart';

class DatabaseService {
  late Realm realm;
  DatabaseService() {
    final config = Configuration([Car.schema, Person.schema]);
    // delete when schema is changed cannot find any other way for windows
    // Realm.deleteRealm(config.path);
    realm = Realm(config);
  }
  int get carsCount => realm.all<Car>().length;

  seedData() {
    deleteAllCars();
    deleteAllPerson();
    var allItems = realm.all<Car>();

    if (allItems.isEmpty) {
      realm.write(() {
        realm.addAll(dummyDataCars);
      });
    }
// adding one of the model as my fav
    var car = searchCarByModel("Model Y");
    if (car != null) {
      var mycar = car.first;
      print("Changing the owner of the car.");
      realm.write(() {
        mycar.owner = Person("me", age: 40);
      });
      print("The car has a new owner ${mycar.owner!.name}");
    }
  }

  RealmResults<Car> getAllCars() {
    print("Getting all cars from the Realm.");
    var cars = realm.all<Car>();
    print("There are ${cars.length} cars in the Realm.");
    return cars;
  }

  void deleteAllCars() {
    print("Getting all cars from the Realm.");
    realm.write(() {
      var cars = realm.all<Car>();
      realm.deleteMany(cars);
      print("There are ${cars.length} cars in the Realm.");
    });
  }

  void deleteAllPerson() {
    realm.write(() {
      var persons = realm.all<Person>();
      realm.deleteMany(persons);
    });
  }

  RealmResults<Car> searchCarByModel(String model) {
    print("Getting all $model cars from the Realm.");
    var filteredCars = realm.all<Car>().query("model == '$model'");
    print('Found ${filteredCars.length} $model cars');
    return filteredCars;
  }

  void addCarToMe(Car car) {
    var mycar = realm.find<Car>(car.id);
    if (mycar != null) {
      realm.write(() {
        mycar.owner = Person("me", age: 40);
      });
    }
  }

  void removeCarFromMe(Car car) {
    var mycar = realm.find<Car>(car.id);
    if (mycar != null) {
      realm.write(() {
        mycar.owner = null;
      });
    }
  }

  void dispose() {
    realm.close();
  }
}
