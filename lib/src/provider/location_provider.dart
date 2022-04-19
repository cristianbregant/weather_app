import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  String _location = "London";

  City? _city;

  String get location => _location;

  City? get city => _city;

  String get cityLabel => _city != null ? _city!.name! : _location;

  void setLocation(String l) {
    _location = l;
    notifyListeners();
  }

  void setCity(City c) {
    _city = c;
  }
}
