import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/provider/location_provider.dart';
import 'package:alpian_weather_flutter/src/screen/native_view.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:alpian_weather_flutter/src/widgets/settings_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool get isDarkMode => Theme.of(context).brightness == Brightness.dark;

  void _unitsPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, __) {
          return SizedBox(
            height: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: const [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 16, 16, 16),
                        child: Text(
                          "Temperature units",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                ...Units.values.map((t) {
                  return RadioListTile<Units>(
                      value: t,
                      title: Text(t.tempLabel),
                      secondary: Text(t.tempOperator),
                      groupValue: context.watch<AppConfigProvider>().unit,
                      onChanged: (Units? v) {
                        context
                            .read<AppConfigProvider>()
                            .setTemperatureUnit(v!);
                        Utils.weatherForecastBloc.getCityForecast(
                            context.read<LocationProvider>().location, v);
                        Navigator.of(context).pop();
                      });
                })
              ],
            ),
          );
        });
      },
    );
  }

  void _nativePagesPressed() {
    Navigator.of(context).pushNamed(NativeView.routeName);
  }

  void _onChangedThemeMode(darkModeEnabled) {
    setState(() {
      Utils.settingsController!
          .updateThemeMode(darkModeEnabled ? ThemeMode.dark : ThemeMode.light);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: SafeArea(
        child: Column(children: [
          Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 16, 16, 16),
                  child: Text(
                    "Settings",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          SettingsCategory(title: "Preferences", items: [
            SettingsRow(
              child: ListTile(
                dense: true,
                trailing:
                    Text(context.watch<AppConfigProvider>().unit.tempLabel),
                onTap: _unitsPressed,
                title: Text("Temperature Units",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
            SettingsRow(
              child: ListTile(
                dense: true,
                leading: const Text(
                  "Dark mode",
                ),
                trailing: CupertinoSwitch(
                    value: isDarkMode,
                    activeColor: Colors.blue,
                    onChanged: _onChangedThemeMode),
              ),
            ),
            SettingsRow(
              child: ListTile(
                dense: true,
                onTap: _nativePagesPressed,
                title: Text("Native Pages",
                    style: Theme.of(context).textTheme.bodyText1),
              ),
            ),
          ]),
        ]),
      )),
    );
  }
}
