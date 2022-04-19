import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/widgets/detail_info.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_icons/weather_icons.dart';

class SheetFutureForecast extends StatefulWidget {
  final Map<String, dynamic> forecast;
  const SheetFutureForecast({Key? key, required this.forecast})
      : super(key: key);

  @override
  State<SheetFutureForecast> createState() => _SheetFutureForecastState();
}

class _SheetFutureForecastState extends State<SheetFutureForecast> {
  late ListElement _forecastMidday;
  late List<ListElement> _mediumForecasts;
  late String icon;

  @override
  void initState() {
    // get midday information to show
    _forecastMidday = (widget.forecast["forecasts"] as List<ListElement>)
        .singleWhereOrNull((f) => f.dtTxt!.isAtMidday())!;
    _mediumForecasts = [];

    // since the widget shows only 4 forecasts, we will get only the ones that are in even positions
    for (int i = 0; i < widget.forecast["forecasts"].length; i++) {
      if (i % 2 == 0) {
        _mediumForecasts.add(widget.forecast["forecasts"][i]);
      }
    }

    icon = _forecastMidday.weather!.first.icon!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String speedOperator = context.read<AppConfigProvider>().unit.speedOperator;
    String tempOperator = context.read<AppConfigProvider>().unit.tempOperator;

    return ListView(padding: const EdgeInsets.all(16), children: [
      Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.MMMMd().format(_forecastMidday.dtTxt!),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey)),
                const SizedBox(
                  height: 8,
                ),
                Text("${_forecastMidday.main!.temp!.round()} $tempOperator",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    )),
                const SizedBox(
                  height: 8,
                ),
                Text(_forecastMidday.weather!.first.description!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
              ],
            ),
            const Spacer(),
            Image.network(
              "http://openweathermap.org/img/wn/$icon@2x.png",
              width: 100,
            ),
          ],
        ),
      ),
      Row(
        children: [
          Flexible(
              flex: 1,
              child: DetailInfo(
                  icon: FontAwesomeIcons.wind,
                  iconBackground: Colors.green[100]!,
                  iconColor: Colors.green,
                  label: "Wind",
                  value:
                      "${(_forecastMidday.wind!.speed!).round()} $speedOperator")),
          Flexible(
              flex: 1,
              child: DetailInfo(
                  icon: FontAwesomeIcons.umbrella,
                  iconBackground: Colors.blue[100]!,
                  iconColor: Colors.blue,
                  label: "Rain",
                  value: "${(_forecastMidday.pop! * 100).round()} %")),
        ],
      ),
      Row(
        children: [
          Flexible(
              flex: 1,
              child: DetailInfo(
                  icon: Icons.thermostat,
                  iconBackground: Colors.orange[100]!,
                  iconColor: Colors.orange,
                  label: "Temperatures",
                  value:
                      "${widget.forecast["min"]}/${widget.forecast["max"]} $tempOperator")),
          Flexible(
              flex: 1,
              child: DetailInfo(
                  icon: WeatherIcons.humidity,
                  iconBackground: Colors.grey[100]!,
                  iconColor: Colors.grey,
                  label: "Humidity",
                  value: "${_forecastMidday.main!.humidity} %")),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      const Text("Summary", style: TextStyle(fontSize: 16)),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor,
        ),
        margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        padding: const EdgeInsets.fromLTRB(4, 16, 12, 16),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(_mediumForecasts.length, (index) {
              ListElement _l = _mediumForecasts.elementAt(index);
              String icon = _l.weather!.first.icon!;

              return Column(
                children: [
                  Image.network(
                    "http://openweathermap.org/img/wn/$icon@2x.png",
                    width: 48,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(DateFormat.H().format(_l.dtTxt!),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              );
            })),
      ),
    ]);
  }
}
