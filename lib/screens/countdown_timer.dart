import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_countdown_timer/index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int targetHour = 12;
  int targetMinute = 35;
  int targetSecond = 00;
  int currentHour = DateTime.now().hour;
  int currentMinute = DateTime.now().minute;
  int currentSecond = DateTime.now().second;
  AudioPlayer audio = AudioPlayer();
  playAudio() {
    return audio
        .play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
  }

  int noOfDays =
      0; // the noOfDays will be 0 if current time is more than the target time else 1
  Duration? timeLeft; // difference between target time and Current time
  void initState() {
    // will call before the Build method and only once
    // super.initState();

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
    timeLeft = targetTime.difference(
        currentTime); // difference between target time and Current time
  }

  @override
  Widget build(BuildContext context) {
    var enableAudioBefore = 60; //in seconds
    var enableAudioAt = timeLeft!.inSeconds -
        enableAudioBefore; // '!' is for null safety, 'enableAudio' is the variable time left to rise alarm in seconds
    Timer.periodic(Duration(seconds: 1), (timer) {
      //calls the function for every 1 second which decrements the enableAudio by -1  abd will rise an alarm when it equals to 0

      if (enableAudioAt == 0) {
        playAudio();
      }
      enableAudioAt--;
    });

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("target-${targetHour}:${targetMinute}:${targetSecond}"),
          CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                timeLeft!.inSeconds * 1000,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            onEnd: () {
              setState(() {
                timeLeft = Duration(hours: 24, minutes: 0, seconds: 0);
              });
            },
          ),
        ],
      )),
    );
  }
}
