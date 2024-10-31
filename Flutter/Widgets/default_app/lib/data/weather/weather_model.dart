import 'dart:convert';

import 'package:intl/intl.dart';

class CityWeatherModel {
  Results results;

  CityWeatherModel({
    required this.results,
  });

  factory CityWeatherModel.fromJson(String str) =>
      CityWeatherModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CityWeatherModel.fromMap(Map<String, dynamic> json) =>
      CityWeatherModel(
        results: Results.fromMap(json["results"]),
      );

  Map<String, dynamic> toMap() => {
        "results": results.toMap(),
      };
}

class Results {
  int temp;
  DateTime date;
  String time;
  String description;
  String imgId;
  int humidity;
  double cloudiness;
  double rain;
  String windSpeedy;
  String cityName;
  String sunrise;
  String sunset;
  String currently;
  int windDirection;
  List<Forecast> forecast;

  Results({
    required this.temp,
    required this.date,
    required this.time,
    required this.description,
    required this.imgId,
    required this.humidity,
    required this.cloudiness,
    required this.rain,
    required this.windSpeedy,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
    required this.currently,
    required this.windDirection,
    required this.forecast,
  });

  factory Results.fromJson(String str) => Results.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Results.fromMap(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat('d/M/y');
    String date = json["date"];
    DateTime dateTime = dateFormat.parse(date);

    return Results(
      temp: json["temp"],
      date: dateTime,
      time: json["time"],
      description: json["description"],
      imgId: json["img_id"],
      humidity: json["humidity"],
      cloudiness: json["cloudiness"],
      rain: json["rain"],
      windSpeedy: json["wind_speedy"],
      cityName: json["city_name"],
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      currently: json["currently"],
      windDirection: json["wind_direction"],
      forecast:
          List<Forecast>.from(json["forecast"].map((x) => Forecast.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "temp": temp,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "description": description,
        "img_id": imgId,
        "humidity": humidity,
        "cloudiness": cloudiness,
        "rain": rain,
        "wind_speedy": windSpeedy,
        "city_name": cityName,
        "sunrise": sunrise,
        "sunset": sunset,
        "currently": currently,
        "wind_direction": windDirection,
        "forecast": List<dynamic>.from(forecast.map((x) => x.toMap())),
      };
}

class Forecast {
  String date;
  String weekday;
  int max;
  int min;
  double cloudiness;
  double rain;
  int rainProbability;
  String windSpeedy;
  String description;
  String condition;

  Forecast({
    required this.date,
    required this.weekday,
    required this.max,
    required this.min,
    required this.cloudiness,
    required this.rain,
    required this.rainProbability,
    required this.windSpeedy,
    required this.description,
    required this.condition,
  });

  factory Forecast.fromJson(String str) => Forecast.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Forecast.fromMap(Map<String, dynamic> json) => Forecast(
        date: json["date"],
        weekday: json["weekday"],
        max: json["max"],
        min: json["min"],
        cloudiness: json["cloudiness"],
        rain: json["rain"]?.toDouble(),
        rainProbability: json["rain_probability"],
        windSpeedy: json["wind_speedy"],
        description: json["description"],
        condition: json["condition"],
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "weekday": weekday,
        "max": max,
        "min": min,
        "cloudiness": cloudiness,
        "rain": rain,
        "rain_probability": rainProbability,
        "wind_speedy": windSpeedy,
        "description": description,
        "condition": condition,
      };
}
