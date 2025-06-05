import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:weather_app/models/weather.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse notificationResponse) {}

  static Future initNotificationService() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveBackgroundNotificationResponse: onTap,
      onDidReceiveNotificationResponse: onTap,
    );
  }

  static Future<void> showNotification(Weather weather) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channelId-0',
      'channelName-weather',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(
      tz.getLocation(currentTimeZone),
    );
    final tz.Location location = tz.local;
    final tz.TZDateTime now = tz.TZDateTime.now(location);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      7
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    // Customize the notification content with weather data
    String notificationTitle = 'Weather Today';
    String notificationBody =
        '${weather.areaName}: ${weather.temperatureCelsius.round()}°C, ${weather.weatherMain}';

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      notificationTitle,
      notificationBody,
      scheduledDate,
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
