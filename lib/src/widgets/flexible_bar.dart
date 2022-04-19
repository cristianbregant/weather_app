import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/provider/location_provider.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FlexibleBar extends StatelessWidget {
  final ListElement currentForecast;
  final int dateMillis;
  const FlexibleBar(
      {Key? key, required this.currentForecast, required this.dateMillis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      var top = constraints.biggest.height;

      int temperature = currentForecast.main!.temp!.round();

      String label = currentForecast.weather!.first.main!;

      String icon = currentForecast.weather!.first.icon!;

      LocationProvider _lP = context.read<LocationProvider>();

      String city = _lP.cityLabel;

      DateTime _dateTime = DateTime.fromMillisecondsSinceEpoch(dateMillis);
      String lastUpdate = "Last update: ";

      if (_dateTime.isToday()) {     
        // 09:00 AM                             
        lastUpdate += DateFormat.jm().format(_dateTime);
      } else {
        // 19/04/2022 09:00AM
        lastUpdate += DateFormat("dd/MM/yyyy jm").format(_dateTime);
      }

      String tempOperator = context.read<AppConfigProvider>().unit.tempOperator;

      String temperatureText = "$temperature $tempOperator";

      return FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        background: Image.asset(
          Utils.getBackgroundImage(currentForecast),
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
        ),
        title: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: 1.0,
            child: top > 128
                ? SafeArea(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          children: [
                            Text(city,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  "http://openweathermap.org/img/wn/$icon@2x.png",
                                  width: 80,
                                ),
                                Text(temperatureText,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32,
                                        color: Colors.white)),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(label,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white)),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(lastUpdate,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text(
                    DateFormat.MMMMEEEEd().format(currentForecast.dtTxt!),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
      );
    });
  }
}
