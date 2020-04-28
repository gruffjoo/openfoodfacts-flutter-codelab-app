import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalSettingsProvider extends ChangeNotifier {
  SharedPreferences _preferences;

  double _age = 0;
  double get age => _age;

  double _weight = 0;
  double get weight => _weight;

  // Lifecycle

  void initializeValues() async {
    _preferences = await SharedPreferences.getInstance();
    _age = _preferences.getDouble("age") ?? 0;
    _weight = _preferences.getDouble("weight") ?? 0;
    notifyListeners();
  }

  // Setter

  Future setAge(double newValue) {
    _preferences.setDouble("age", newValue);
    _age = newValue;
    notifyListeners();
  }

  Future setWeight(double newValue) {
    _preferences.setDouble("weight", newValue);
    _weight = newValue;
    notifyListeners();
  }
}
