import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';

class Hourly extends StatelessWidget {
  final WeatherForecast weatherForecast;
  const Hourly({Key? key, required this.weatherForecast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hourly", style: TextStyle(fontSize: 16)),
        SizedBox(
          height: 112,
          child: ListView.builder(
              itemCount: weatherForecast.list!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((BuildContext context, index) =>
                  _hourly(context, weatherForecast.list!.elementAt(index)))),
        ),
      ],
    );
  }

  Widget _hourly(BuildContext context, ListElement le) {
    String tempOperator = context.read<AppConfigProvider>().unit.tempOperator;
    String temperature = "${le.main!.temp!.round()}";
    String icon = le.weather!.first.icon!;
    String hour = DateFormat.jm().format(le.dtTxt!);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
      ),
      margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            "http://openweathermap.org/img/wn/$icon@2x.png",
            width: 40,
          ),
          const SizedBox(
            height: 4,
          ),
          Text("$temperature $tempOperator",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(
            height: 4,
          ),
          Text(hour,
              style:
                  const TextStyle(fontWeight: FontWeight.w300, fontSize: 10)),
        ],
      ),
    );
  }
}
