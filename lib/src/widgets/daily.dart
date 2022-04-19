import 'dart:math';

import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/widgets/sheet_future_forecast.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:intl/intl.dart';

class Daily extends StatelessWidget {
  final WeatherForecast weatherForecast;
  const Daily({Key? key, required this.weatherForecast}) : super(key: key);

  _onDailyTap(BuildContext context, var dailyForecast) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SheetFutureForecast(forecast: dailyForecast);
        });
  }

  ///
  /// Since the API return the weather forecast for the next days always by 3 hour steps from the GET,
  /// this function will group by day the forecasts and return and add some additionals for the midday information of that day.
  ///
  List<dynamic> _weatherDays(List<ListElement> le) {
    // group all forecasts by date
    final dailyForecasts = groupBy(le, (ListElement e) {
      return e.dtTxt!.toIso8601String().substring(0, 10);
    });

    List<Map<String, dynamic>> dailyList = [];

    //for each day
    dailyForecasts.forEach((day, groupedForecast) {
      
      // get the minimum temperature for this day
      double _min = groupedForecast
          .map((f) => f.main!.tempMin)
          .reduce((value, element) => min(value!, element!))!;
      
      // get the maximum temperature for this day
      double _max = groupedForecast
          .map((f) => f.main!.tempMax)
          .reduce((value, element) => max(value!, element!))!;
      
      // if in this specific day there is no midday value we cant get generic information about that day so we will skip it
      if (groupedForecast.singleWhereOrNull((f) => f.dtTxt!.isAtMidday()) ==
          null) return;

      // Here we get the label like "Cloud" for the forecast ad 12:00 to show as ideally weather for that specific day
      String _middayForecastLabel = groupedForecast
          .singleWhereOrNull((f) => f.dtTxt!.isAtMidday())!
          .weather!
          .first
          .description!;

      // Here we get the icon like "20d" for the forecast ad 12:00 to show as ideally weather for that specific day
      String _middayForecastIcon = groupedForecast
          .singleWhereOrNull((f) => f.dtTxt!.isAtMidday())!
          .weather!
          .first
          .icon!;


      Map<String, dynamic> _singleDay = {
        "date": day,
        "min": _min.round().toString(),
        "max": _max.round().toString(),
        "midday_forecast_label": _middayForecastLabel,
        "icon": _middayForecastIcon,
        "forecasts": groupedForecast
      };

      dailyList.add(_singleDay);
    });

    return dailyList;
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _lW = _weatherDays(weatherForecast.list!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Next Days", style: TextStyle(fontSize: 16)),
        Column(
            children: List<Widget>.generate(_lW.length, (index) {
          Map<String, dynamic> _singleDay = _lW.elementAt(index);

          String min = _singleDay["min"];
          String max = _singleDay["max"];
          String label = _singleDay["midday_forecast_label"];
          String icon = _singleDay["icon"];

          return GestureDetector(
            onTap: () => _onDailyTap(context, _singleDay),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
              ),
              margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              padding: const EdgeInsets.fromLTRB(4, 12, 12, 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Image.network(
                      "http://openweathermap.org/img/wn/$icon@2x.png",
                      width: 60,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          DateFormat.EEEE().format(DateFormat("yyyy-MM-dd")
                              .parse(_singleDay["date"])),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(label,
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 10)),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text("$min°"),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text("/"),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "$max°",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }))
      ],
    );
  }
}
