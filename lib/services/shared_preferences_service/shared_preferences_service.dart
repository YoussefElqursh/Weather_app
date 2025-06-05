import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather.dart';


class SharedPreferencesService {
  static Future<void> saveWeatherData(Weather weather) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(weather.toJson()); // Serialize to JSON string
    await prefs.setString('lastWeatherData', jsonString);
  }

  static Future<Weather?> getLastWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('lastWeatherData');
    if (jsonString != null) {
      return Weather.fromJson(jsonString); // Deserialize from JSON string
    }
    return null;
  }
}