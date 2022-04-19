import 'package:alpian_weather_flutter/src/bloc/weather_forecast_bloc.dart';
import 'package:alpian_weather_flutter/src/model/logs_helper.dart';
import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/settings/settings_controller.dart';
import 'package:alpian_weather_flutter/src/utils/hive_helper.dart';

class Utils {
  static late LogsHelper logsHelper;
  static SettingsController? settingsController;
  static late HiveHelper hiveHelper;
  static late WeatherForecastBloc weatherForecastBloc;
  static int? lastUpdate;

  static String getBackgroundImage(ListElement _wf) {
    String path = "assets/images/";
    late String image;
    switch (_wf.weather!.first.main) {
      case "Clouds":
        image = "cloud.jpg";
        break;
      case "Rain":
        image = "rain.jpg";
        break;
      case "Sun":
        image = "sun.jpg";
        break;
      case "Snow":
        image = "snow.jpg";
        break;

      default:
        image = "scattered-clouds.jpg";
    }

    return path + image;
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isAtMidday() {
    return hour == 12 && minute == 00;
  }

  bool isToday() {
    DateTime now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}

enum Units { standard, imperial, metric }

extension UnitsExtension on Units {
  String get tempOperator {
    switch (this) {
      case Units.standard:
        return "°K";
      case Units.imperial:
        return "°F";
      case Units.metric:
        return "°C";
    }
  }

  String get tempLabel {
    switch (this) {
      case Units.standard:
        return "Kelvin";
      case Units.imperial:
        return "Fahreneit";
      case Units.metric:
        return "Celsius";
    }
  }

  String get speedOperator {
    switch (this) {
      case Units.standard:
        return "m/s";
      case Units.imperial:
        return "mph";
      case Units.metric:
        return "m/s";
    }
  }
}
