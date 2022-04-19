import 'package:alpian_weather_flutter/src/app.dart';
import 'package:alpian_weather_flutter/src/model/logs_helper.dart';
import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/provider/location_provider.dart';
import 'package:alpian_weather_flutter/src/settings/settings_controller.dart';
import 'package:alpian_weather_flutter/src/settings/settings_services.dart';
import 'package:alpian_weather_flutter/src/utils/hive_helper.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

Future<void> main() async {
  bool _logsEnabled = true;
  if (isProduction) {
    _logsEnabled = false;
  }

  Utils.logsHelper = LogsHelper(_logsEnabled);

  await dotenv.load(fileName: ".env");

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  Utils.settingsController = settingsController;

  Utils.hiveHelper = HiveHelper();

  await Utils.hiveHelper.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppConfigProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider())
  ], child: const MyApp()));
}
