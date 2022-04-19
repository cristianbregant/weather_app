import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  Units _unit = Units.metric;

  Units get unit => _unit;

  void setTemperatureUnit(Units t) {
    _unit = t;
    notifyListeners();
  }
}
