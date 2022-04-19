import 'dart:async';
import 'dart:io';

import 'package:alpian_weather_flutter/src/helper/api_response.dart';
import 'package:alpian_weather_flutter/src/helper/app_exception.dart';
import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/repository/open_weather_repository.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';

class WeatherForecastBloc {
  late OpenWeatherRepository _repository;

  late StreamController<ApiResponse<WeatherForecast>>
      _weatherForecastController;

  StreamSink<ApiResponse<WeatherForecast>> get weatherForecastSink =>
      _weatherForecastController.sink;

  Stream<ApiResponse<WeatherForecast>> get stream =>
      _weatherForecastController.stream;

  WeatherForecastBloc() {
    _weatherForecastController =
        StreamController<ApiResponse<WeatherForecast>>.broadcast();
    _repository = OpenWeatherRepository();
  }

  getCityForecast(String? city, Units _tU) async {
    weatherForecastSink.add(ApiResponse.loading("Getting forecast..."));

    try {
      var response = await _repository.getCityForecast(city ?? "London", _tU);

      Utils.lastUpdate = DateTime.now().millisecondsSinceEpoch;
      var _map = {"date": Utils.lastUpdate, "forecast": response};
      Utils.hiveHelper.forecasts.add(_map);

      weatherForecastSink.add(ApiResponse.completed(response));
    } on SocketException {
      weatherForecastSink.add(ApiResponse.error("network_error"));
    } on LocationException {
      weatherForecastSink.add(ApiResponse.error("location_error"));
    } catch (error) {
      weatherForecastSink.add(ApiResponse.error(error.toString()));
    }
  }

  dispose() {
    weatherForecastSink.close();
  }
}
