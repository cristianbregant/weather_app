import 'dart:io';

import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  late Box<Map<String, dynamic>> forecasts;
  initialize() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);

    Hive.registerAdapter(WeatherForecastAdapter());
    Hive.registerAdapter(CityAdapter());
    Hive.registerAdapter(CoordAdapter());
    Hive.registerAdapter(ListElementAdapter());
    Hive.registerAdapter(CloudsAdapter());
    Hive.registerAdapter(MainAdapter());
    Hive.registerAdapter(RainAdapter());
    Hive.registerAdapter(SysAdapter());
    Hive.registerAdapter(WeatherAdapter());
    Hive.registerAdapter(WindAdapter());

    forecasts = await Hive.openBox<Map<String, dynamic>>("forecasts");
  }
}
