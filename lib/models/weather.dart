import 'dart:convert';
import 'package:weather/weather.dart' as weather_package;

class Weather {
  final String areaName;
  final DateTime date;
  final int weatherConditionCode;
  final double temperatureCelsius;
  final double tempMaxCelsius;
  final double tempMinCelsius;
  final String weatherMain;
  final DateTime sunrise;
  final DateTime sunset;

  Weather({
    required this.areaName,
    required this.date,
    required this.weatherConditionCode,
    required this.temperatureCelsius,
    required this.tempMaxCelsius,
    required this.tempMinCelsius,
    required this.weatherMain,
    required this.sunrise,
    required this.sunset,
  });

  Map<String, dynamic> toJson() {
    return {
      'areaName': areaName,
      'date': date.toIso8601String(),
      'weatherConditionCode': weatherConditionCode,
      'temperatureCelsius': temperatureCelsius,
      'tempMaxCelsius': tempMaxCelsius,
      'tempMinCelsius': tempMinCelsius,
      'weatherMain': weatherMain,
      'sunrise': sunrise.toIso8601String(),
      'sunset': sunset.toIso8601String(),
    };
  }

  factory Weather.fromJson(String jsonString) {
    final jsonMap = jsonDecode(jsonString);
    return Weather(
      areaName: jsonMap['areaName'],
      date: DateTime.parse(jsonMap['date']),
      weatherConditionCode: jsonMap['weatherConditionCode'],
      temperatureCelsius: jsonMap['temperatureCelsius'],
      tempMaxCelsius: jsonMap['tempMaxCelsius'],
      tempMinCelsius: jsonMap['tempMinCelsius'],
      weatherMain: jsonMap['weatherMain'],
      sunrise: DateTime.parse(jsonMap['sunrise']),
      sunset: DateTime.parse(jsonMap['sunset']),
    );
  }
}

Weather mapToCustomWeather(weather_package.Weather weather) {
  return Weather(
    areaName: weather.areaName ?? 'Unknown',
    date: weather.date ?? DateTime.now(),
    weatherConditionCode: weather.weatherConditionCode ?? 0,
    temperatureCelsius: weather.temperature?.celsius ?? 0.0,
    tempMaxCelsius: weather.tempMax?.celsius ?? 0.0,
    tempMinCelsius: weather.tempMin?.celsius ?? 0.0,
    weatherMain: weather.weatherMain ?? 'Unknown',
    sunrise: weather.sunrise ?? DateTime.now(),
    sunset: weather.sunset ?? DateTime.now(),
  );
}