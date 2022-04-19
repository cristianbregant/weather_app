import 'dart:convert';

import 'package:alpian_weather_flutter/src/helper/app_exception.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  late String baseUrl;

  ApiBaseHelper({required this.baseUrl});

  Future<dynamic> get(String url, {dynamic header}) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(baseUrl + url), headers: header);
      responseJson = _returnResponse(response);
    } catch (error) {
      Utils.logsHelper.log(error.toString());
      rethrow;
    }
    return responseJson;
  } //

  Future<dynamic> post(String url, {dynamic body, dynamic header}) async {
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(baseUrl + url),
          body: body, headers: header);
      responseJson = _returnResponse(response);
    } catch (error) {
      Utils.logsHelper.log(error.toString());
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> put(String url, {dynamic body, dynamic header}) async {
    dynamic responseJson;
    try {
      final response =
          await http.put(Uri.parse(baseUrl + url), body: body, headers: header);
      responseJson = _returnResponse(response);
    } catch (error) {
      Utils.logsHelper.log(error.toString());
      rethrow;
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw BadTokenException(json.decode(response.body)["msg"]);
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw LocationException(json.decode(response.body)["message"]);
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
