import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  String name;
  String dateTime;
  String address;

  AppointmentProvider({
    this.name =
        "Chua E Heng", // NOTE: NEED TO DO FIREBASE AUTH, TEMPORARY SOLUTION
    this.dateTime = "",
    this.address = "",
  });

  void changeName({required String newName}) async {
    name = newName;
    notifyListeners();
  }

  void changeDateTime({required String newDateTime}) async {
    dateTime = newDateTime;
    notifyListeners();
  }

  void changeAddress({required String newAddress}) async {
    address = newAddress;
    notifyListeners();
  }
}
