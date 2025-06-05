import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/local_notification_service/local_notification_service.dart';
import 'package:weather_app/services/shared_preferences_service/shared_preferences_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  static Future<void> initWorkManagerService() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
    Workmanager().registerPeriodicTask(
      "NotificationID",
      "DailyNotificationTask",
      frequency: Duration(hours: 12),
    );
  }
}

@pragma(
  'vm:entry-point',
)
void callbackDispatcher() {
  Workmanager().executeTask(
    (task, inputData) async {
      Weather? weather = await SharedPreferencesService.getLastWeatherData();

      // If no weather data is available, do not show the notification
      if (weather != null) {
        await LocalNotificationService.showNotification(weather);
      }
      return Future.value(true);
    },
  );
}
