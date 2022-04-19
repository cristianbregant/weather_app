import 'package:alpian_weather_flutter/src/route_generator.dart';
import 'package:alpian_weather_flutter/src/screen/root.dart';
import 'package:alpian_weather_flutter/src/utils/styles.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Utils.settingsController!,
        builder: (context, child) {
          return MaterialApp(
            title: 'Alpian Weather Flutter',
            theme: Styles.light,
            darkTheme: Styles.dark,
            themeMode: Utils.settingsController!.themeMode,
            onGenerateRoute: RouteGenerator.onGenerateRoute,
            initialRoute: Root.routeName,
          );
        });
  }
}
