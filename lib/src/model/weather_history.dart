import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:hive/hive.dart';

part "weather_history.g.dart";

@HiveType(typeId: 0)
class WeatherHistory {
  @HiveField(0)
  WeatherForecast forecast;
  @HiveField(1)
  int date;

  WeatherHistory({required this.forecast, required this.date});
}
