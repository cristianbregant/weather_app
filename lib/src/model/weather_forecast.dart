import 'dart:convert';
import 'package:hive/hive.dart';

part "weather_forecast.g.dart";

WeatherForecast weatherForecastFromJson(String str) =>
    WeatherForecast.fromJson(json.decode(str));

String weatherForecastToJson(WeatherForecast data) =>
    json.encode(data.toJson());

@HiveType(typeId: 1)
class WeatherForecast {
  WeatherForecast({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
  @HiveField(0)
  String? cod;
  @HiveField(1)
  int? message;
  @HiveField(2)
  int? cnt;
  @HiveField(3)
  List<ListElement>? list;
  @HiveField(4)
  City? city;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      WeatherForecast(
        cod: json["cod"],
        message: json["message"],
        cnt: json["cnt"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        city: City.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "cod": cod,
        "message": message,
        "cnt": cnt,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
        "city": city?.toJson(),
      };
}

@HiveType(typeId: 2)
class City {
  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  Coord? coord;
  @HiveField(3)
  String? country;
  @HiveField(4)
  int? population;
  @HiveField(5)
  int? timezone;
  @HiveField(6)
  int? sunrise;
  @HiveField(7)
  int? sunset;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord?.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}

@HiveType(typeId: 3)
class Coord {
  Coord({
    this.lat,
    this.lon,
  });
  @HiveField(0)
  double? lat;
  @HiveField(1)
  double? lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

@HiveType(typeId: 4)
class ListElement {
  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.sys,
    this.dtTxt,
    this.rain,
  });
  @HiveField(0)
  int? dt;
  @HiveField(1)
  Main? main;
  @HiveField(2)
  List<Weather>? weather;
  @HiveField(3)
  Clouds? clouds;
  @HiveField(4)
  Wind? wind;
  @HiveField(5)
  int? visibility;
  @HiveField(6)
  double? pop;
  @HiveField(7)
  Sys? sys;
  @HiveField(8)
  DateTime? dtTxt;
  @HiveField(9)
  Rain? rain;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        pop: json["pop"].toDouble(),
        sys: Sys.fromJson(json["sys"]),
        dtTxt: DateTime.parse(json["dt_txt"]),
        rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "main": main?.toJson(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
        "clouds": clouds?.toJson(),
        "wind": wind?.toJson(),
        "visibility": visibility,
        "pop": pop,
        "sys": sys?.toJson(),
        "dt_txt": dtTxt?.toIso8601String(),
        "rain": rain == null ? null : rain!.toJson(),
      };
}

@HiveType(typeId: 5)
class Clouds {
  Clouds({
    this.all,
  });

  int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

@HiveType(typeId: 6)
class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
  @HiveField(0)
  double? temp;
  @HiveField(1)
  double? feelsLike;
  @HiveField(2)
  double? tempMin;
  @HiveField(3)
  double? tempMax;
  @HiveField(4)
  int? pressure;
  @HiveField(5)
  int? seaLevel;
  @HiveField(6)
  int? grndLevel;
  @HiveField(7)
  int? humidity;
  @HiveField(8)
  double? tempKf;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"].toDouble(),
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
        humidity: json["humidity"],
        tempKf: json["temp_kf"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
        "humidity": humidity,
        "temp_kf": tempKf,
      };
}

@HiveType(typeId: 7)
class Rain {
  Rain({
    this.the3H,
  });
  @HiveField(0)
  double? the3H;

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
        the3H: json["3h"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "3h": the3H,
      };
}

@HiveType(typeId: 8)
class Sys {
  Sys({
    this.pod,
  });
  @HiveField(0)
  String? pod;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        pod: json["pod"],
      );

  Map<String, dynamic> toJson() => {
        "pod": pod,
      };
}

@HiveType(typeId: 9)
class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? main;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

@HiveType(typeId: 10)
class Wind {
  Wind({
    this.speed,
    this.deg,
    this.gust,
  });
  @HiveField(0)
  double? speed;
  @HiveField(1)
  int? deg;
  @HiveField(2)
  double? gust;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
        gust: json["gust"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
        "gust": gust,
      };
}
