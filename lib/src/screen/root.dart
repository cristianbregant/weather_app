import 'package:alpian_weather_flutter/src/screen/homepage.dart';
import 'package:alpian_weather_flutter/src/screen/location.dart';
import 'package:alpian_weather_flutter/src/screen/settings.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  static const String routeName = "/";

  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
          index: currentIndex,
          children: const [Homepage(), Location(), Settings()]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            setState(() {
              currentIndex = value;
            });
          }),
          currentIndex: currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.sunny), label: "Weather"),
            BottomNavigationBarItem(icon: Icon(Icons.place), label: "Location"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ]),
    );
  }
}
