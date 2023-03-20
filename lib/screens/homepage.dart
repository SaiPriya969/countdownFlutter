// import 'dart:async';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_countdown_timer/index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CountdownTimerController controller;
  int hrInput = 10;
  int minInput = 52;
  int secInput = 00;
  int displayhr = 10;
  int displaymin = 52;
  int displaysec = 00;
  // int hr = DateTime.now().hour;
  // int min = DateTime.now().minute;
  // int sec = DateTime.now().second;
  AudioPlayer audio = AudioPlayer();
  loadAudio() {
    print("entered");
    return audio
        .play("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
  }

  DateTime getCurrentTime() {
    int currentHour = DateTime.now().hour;

    int currentMinute = DateTime.now().minute;
    int currentSecond = DateTime.now().second;
    DateTime currentTime = DateTime.now().add(Duration(
        hours: currentHour, minutes: currentMinute, seconds: currentSecond));
    print(currentTime);
    print(DateTime.now());
    return currentTime;
  }

  int days = 0;
  Duration? rem;
  Duration remainingTime = Duration(hours: 0);
  void initState() {
    super.initState();
    DateTime currentDuration = getCurrentTime();
    // DateTime.now().add(Duration(hours: hr, minutes: min, seconds: sec));
    //currentDuration to currentTime
    DateTime inputTime =
        DateTime(DateTime.now().day, hrInput, minInput, secInput);
    if (inputTime.isBefore(DateTime.now())) {
      days = 1;
    }
    DateTime inputDuration = DateTime.now().add(Duration(
        days: days, hours: hrInput, minutes: minInput, seconds: secInput));
    remainingTime = inputDuration.difference(currentDuration);

    CountdownTimerController controller = CountdownTimerController(
      endTime: DateTime.now().millisecondsSinceEpoch +
          remainingTime.inSeconds * 1000,
    );
    // controller.addListener(() {
    //   print("jj");
    //   if (controller.currentRemainingTime!.min! <= 2) {
    //     loadAudio();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('hey');

    // print(inputDuration.second +
    //     inputDuration.minute * 60 +
    //     inputDuration.hour * 60 * 60);
    // print(currentDuration.second);
    // remainingTime=rem;
    // print(remainingTime);
    // based on remainingTime.. (+ or -) resturn the scaffold

    // controller.addListener(() {
    //   if (controller.currentRemainingTime!.min! <= 2) {
    //     loadAudio();
    //   }
    // });
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("target-${displayhr}:${displaymin}:${displaysec}"),
          CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                remainingTime.inSeconds * 1000,
            // DateTime.now().millisecondsSinceEpoch + 9000,
            // controller: controller,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

            onEnd: () {
              loadAudio();
              // print("hihr");
              setState(() {
                // inputDuration.add(Duration(days: 1));

                hrInput = 23;
                minInput = 59;
                secInput = 59;
                remainingTime = Duration(hours: 23, minutes: 59, seconds: 59);
                // days = days * 60 * 60 - (remainingTime.inSeconds);
                // days = (days / 60) as int;
                // DateTime currentTime = DateTime.now();
                // DateTime inputTime = DateTime(
                //     currentTime.year,
                //     currentTime.month,
                //     currentTime.day,
                //     hrInput,
                //     minInput,
                //     secInput);
                // DateTime inputDuration = inputTime.add(Duration(days: days));
                // remainingTime = inputDuration.difference(currentTime);

                // secInput = 0;
                // hrInput = 24;
                // minInput = 0;

                // hr = DateTime.now().hour;
                // min = DateTime.now().minute;
                // sec = DateTime.now().second;
              });
            }, //onEnd
          ),
          ElevatedButton(
              onPressed: () {
                // audioInput.play(AssetSource("/audios/audio.wav"));
                loadAudio();
              },
              child: Text("play"))
        ],
      )),
    );
  }
}
