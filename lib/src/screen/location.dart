import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/provider/location_provider.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  late TextEditingController _controller;
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  void _confirmPressed() {
    context.read<LocationProvider>().setLocation(_controller.text);
    Utils.weatherForecastBloc.getCityForecast(
        _controller.text, context.read<AppConfigProvider>().unit);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Location updated"),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(8),
    ));
  }

  @override
  void initState() {
    _controller =
        TextEditingController(text: context.read<LocationProvider>().cityLabel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8.0, 16, 16, 16),
                      child: Text(
                        "Location",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Choose the city for which you want to know the weather forecast",
                          style: TextStyle(fontSize: 18)),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _controller,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton(
                                  onPressed: _confirmPressed,
                                  child: const Text("Confirm"))),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
