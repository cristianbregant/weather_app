import 'package:alpian_weather_flutter/src/bloc/weather_forecast_bloc.dart';
import 'package:alpian_weather_flutter/src/helper/api_response.dart';
import 'package:alpian_weather_flutter/src/model/weather_forecast.dart';
import 'package:alpian_weather_flutter/src/provider/app_config_provider.dart';
import 'package:alpian_weather_flutter/src/provider/location_provider.dart';
import 'package:alpian_weather_flutter/src/utils/utils.dart';
import 'package:alpian_weather_flutter/src/widgets/daily.dart';
import 'package:alpian_weather_flutter/src/widgets/detail_info.dart';
import 'package:alpian_weather_flutter/src/widgets/flexible_bar.dart';
import 'package:alpian_weather_flutter/src/widgets/hourly.dart';
import 'package:alpian_weather_flutter/src/widgets/loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late ScrollController _scrollController;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    Utils.weatherForecastBloc.getCityForecast(
        context.read<LocationProvider>().location,
        context.read<AppConfigProvider>().unit);

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    Utils.weatherForecastBloc = WeatherForecastBloc();
    Utils.weatherForecastBloc.getCityForecast(
        context.read<LocationProvider>().location,
        context.read<AppConfigProvider>().unit);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: StreamBuilder<ApiResponse<dynamic>>(
            stream: Utils.weatherForecastBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const LoadingShimmer();
              }

              switch (snapshot.data!.status) {
                case Status.loading:
                  return const LoadingShimmer();

                case Status.completed:
                  WeatherForecast _wf = snapshot.data!.data;

                  context.read<LocationProvider>().setCity(_wf.city!);
                  return _body(_wf);

                case Status.error:
                  if (snapshot.data?.message == "network_error") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 5),
                        padding: EdgeInsets.all(16),
                        content: Text(
                            "Please check your internet connection or try again later")));
                    if (Utils.hiveHelper.forecasts.isNotEmpty) {
                      var _wf = Utils.hiveHelper.forecasts.values.last;
                      Utils.lastUpdate = _wf["date"];
                      WeatherForecast _lastWeatherForecast = _wf["forecast"];
                      return _body(_lastWeatherForecast);
                    } else {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 120,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "No data to show",
                              style: TextStyle(fontSize: 40),
                            )
                          ],
                        ),
                      );
                    }
                  } else if (snapshot.data?.message == "empty_location") {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.place_outlined,
                            color: Colors.blue,
                            size: 120,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Please set a location to start",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.data?.message == "location_error") {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.error_outline,
                            color: Colors.orangeAccent,
                            size: 120,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Cant find the weather for the choosen location.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Colors.red,
                            size: 120,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "An error occurred, please, try again later.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }

  Widget _body(WeatherForecast _wf) {
    ListElement _currentForecast = _wf.list!.first;
    City _city = _wf.city!;

    ///
    ///eg °C
    ///
    String tempOperator = context.read<AppConfigProvider>().unit.tempOperator;

    ///
    /// eg m/s
    ///
    String speedOperator = context.read<AppConfigProvider>().unit.speedOperator;

    ///
    /// 05:00AM
    ///
    String _hourSunrise = DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(_city.sunrise! * 1000).toUtc());

    ///
    /// 08:00PM
    ///
    String _hourSunset = DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(_city.sunset! * 1000).toUtc());

    ///
    /// 15/32 °C
    ///
    String _temperature =
        "${_currentForecast.main!.tempMin!.round()}/${_currentForecast.main!.tempMax!.round()} $tempOperator";

    ///
    /// 15%
    ///
    String _rainProbability = "${(_currentForecast.pop! * 100).round()} %";

    ///
    /// 5m/s
    ///
    String _windSpeed =
        "${(_currentForecast.wind!.speed!).round()} $speedOperator";

    ///
    /// 20%
    ///
    String _humidity = "${_currentForecast.main!.humidity} %";

    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (_, __) {
          return <Widget>[
            SliverAppBar(
                backgroundColor: Colors.blue[800],
                expandedHeight: 200,
                flexibleSpace: FlexibleBar(
                    currentForecast: _currentForecast,
                    dateMillis: Utils.lastUpdate!))
          ];
        },
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: DetailInfo(
                          icon: FontAwesomeIcons.wind,
                          iconBackground: Colors.green[100]!,
                          iconColor: Colors.green,
                          label: "Wind",
                          value: _windSpeed)),
                  Flexible(
                      flex: 1,
                      child: DetailInfo(
                          icon: FontAwesomeIcons.umbrella,
                          iconBackground: Colors.blue[100]!,
                          iconColor: Colors.blue,
                          label: "Rain",
                          value: _rainProbability)),
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
                          value: _temperature)),
                  Flexible(
                      flex: 1,
                      child: DetailInfo(
                          icon: FontAwesomeIcons.percent,
                          iconBackground: Colors.purple[100]!,
                          iconColor: Colors.purple,
                          label: "Humidity",
                          value: _humidity)),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: DetailInfo(
                          icon: FontAwesomeIcons.sun,
                          iconBackground: Colors.red[100]!,
                          iconColor: Colors.red,
                          label: "Sunrise",
                          value: _hourSunrise)),
                  Flexible(
                      flex: 1,
                      child: DetailInfo(
                          icon: FontAwesomeIcons.moon,
                          iconBackground: Colors.grey[100]!,
                          iconColor: Colors.grey,
                          label: "Sunset",
                          value: _hourSunset)),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Hourly(
                weatherForecast: _wf,
              ),
              const SizedBox(
                height: 16,
              ),
              Daily(
                weatherForecast: _wf,
              )
            ],
          ),
        ));
  }
}
