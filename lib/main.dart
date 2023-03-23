// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:countdown/screens/countdown_timer.dart';
import 'package:countdown/services/notification_service.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyNotificationService().init();
  // await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountdownTimerWidget(),
    );
  }
}
