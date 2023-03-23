import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MyNotificationService {
  FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("app_icon");
    InitializationSettings initialSettings =
        InitializationSettings(android: androidSettings);
    await notificationPlugin.initialize(initialSettings);

    tz.initializeTimeZones();
  }

  Future<void> showNotificaton() async {
    await notificationPlugin.show(
      0,
      "Infinitheism",
      "Hello",
      const NotificationDetails(
        android: AndroidNotificationDetails("2", "hi",
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: DefaultStyleInformation(true, true),
            playSound: true,
            icon: "app_icon",
            sound: RawResourceAndroidNotificationSound("alarm"),
            timeoutAfter: 60000),
      ),
    );
  }
}
