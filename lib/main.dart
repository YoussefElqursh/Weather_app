import 'package:flutter/material.dart';
import 'package:weather_app/services/local_notification_service/local_notification_service.dart';
import 'package:weather_app/services/shared_preferences_service/shared_preferences_service.dart';
import 'package:weather_app/services/work_manager_service/work_manager_service.dart';
import 'package:weather_app/weather_app.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'models/weather.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  Future.wait([
    LocalNotificationService.initNotificationService(),
    WorkManagerService.initWorkManagerService(),
  ]);

  Weather? lastWeather = await   SharedPreferencesService.getLastWeatherData();
  if (lastWeather != null) {
    await LocalNotificationService.showNotification(lastWeather);
  }

  runApp(
    const WeatherApp(),
  );
}
