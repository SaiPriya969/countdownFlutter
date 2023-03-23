import 'dart:async';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:audioplayers/notifications.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_countdown_timer/index.dart';
import '../services/notification_service.dart';
// import 'package:just_audio/just_audio.dart';

class CountdownTimerWidget extends StatefulWidget {
  const CountdownTimerWidget({super.key, title});

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  int targetHour = 13;
  int targetMinute = 4;
  int targetSecond = 00;
  int currentHour = DateTime.now().hour;
  int currentMinute = DateTime.now().minute;
  int currentSecond = DateTime.now().second;
  AudioPlayer audio = AudioPlayer();
  MyNotificationService notification = MyNotificationService();
  playAudio() async {
    // await audio.setUrl(
    //     "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
    return audio
        .play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
  }

  int noOfDays =
      0; // the noOfDays will be 0 if current time is more than the target time else 1
  Duration? timeLeft; // difference between target time and Current time
  @override
  void initState() {
    super.initState();
    // will call before the Build method and only once
    // super.initState();
    // notification.init();
    DateTime currentTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, currentHour, currentMinute, currentSecond);

    DateTime targetTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, targetHour, targetMinute, targetSecond);
    // targetTime is for converting the inputs to time format

    if (targetTime.isBefore(DateTime.now())) {
      // checking whether the target time is triggered today or tomorrows time
      noOfDays = 1; // triggering to the next day according to date
    }
    targetTime = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day + noOfDays, targetHour, targetMinute, targetSecond);
    // targetTime is updated based by updating noOfDays
    timeLeft = targetTime.difference(currentTime);
    // difference between target time and Current time
  }

  @override
  Widget build(BuildContext context) {
    // play() async {
    //   print("entered");
    //   await AndroidAlarmManager.oneShotAt(
    //       DateTime(2023, 3, 33, 0, 17), 1, playAudio());
    // }

    // play();
    var enableAudioBefore = 60; //in seconds
    var enableAudioAt = timeLeft!.inSeconds -
        enableAudioBefore; // '!' is for null safety, 'enableAudio' is the variable time left to rise alarm in seconds
    Timer.periodic(const Duration(seconds: 1), (timer) {
      //calls the function for every 1 second which decrements the enableAudio by -1  abd will rise an alarm when it equals to 0

      if (enableAudioAt == 0) {
        // notification.showNotificaton();
        playAudio();
        notification.showNotificaton();
      }
      enableAudioAt--;
    });

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("target-$targetHour:$targetMinute:$targetSecond"),
          CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                timeLeft!.inSeconds * 1000,
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            onEnd: () {
              audio.pause();
              setState(() {
                timeLeft = const Duration(hours: 24, minutes: 0, seconds: 0);
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                notification.showNotificaton();
              },
              child: Text("show"))
        ],
      )),
    );
  }
}
