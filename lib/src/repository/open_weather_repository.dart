import 'package:alpian_weather_flutter/src/helper/api_base_helper.dart';
import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenWeatherRepository {
  late ApiBaseHelper _apiBaseHelper;

  OpenWeatherRepository() {
    _apiBaseHelper = ApiBaseHelper(baseUrl: "https://api.openweathermap.org");
  }

  Future<WeatherForecast> getCityForecast(
      String cityName, Units _tU) async {
    String appid = dotenv.env['openweather_appid']!;
    String unit = _tU.name;
    String url = "/data/2.5/forecast?q=$cityName&appid=$appid&units=$unit";
    final response = await _apiBaseHelper.get(url);
    return WeatherForecast.fromJson(response);
  }
}
