import 'package:alpian_weather_flutter/src/screen/native_view.dart';
import 'package:alpian_weather_flutter/src/screen/root.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings _routeSettings) {
    switch (_routeSettings.name) {
      case Root.routeName:
        return MaterialPageRoute(
            builder: (_) => const Root(), settings: _routeSettings);

      case NativeView.routeName:
        return MaterialPageRoute(
            builder: (_) => const NativeView(), settings: _routeSettings);
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
