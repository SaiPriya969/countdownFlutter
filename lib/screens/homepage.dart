// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:audioplayers/audioplayers.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CountdownTimerController controller;
  int hrInput = 14;
  int minInput = 37;
  int secInput = 00;
  int displayhr = 14;
  int displaymin = 37;
  int displaysec = 00;
  int hr = DateTime.now().hour;
  int min = DateTime.now().minute;
  int sec = DateTime.now().second;

  int days = 0;
  Duration? rem;
  Duration remainingTime = Duration(hours: 0);
  void initState() {
    super.initState();
    DateTime currentDuration =
        DateTime.now().add(Duration(hours: hr, minutes: min, seconds: sec));
    //currentDuration to currentTime
    DateTime inputDuration = DateTime.now().add(Duration(
        days: days, hours: hrInput, minutes: minInput, seconds: secInput));
    // int remainingTime = inputDuration - currentDuration.inSeconds;
    // if(inputDuration.difference(currentDuration)){
    remainingTime = inputDuration.difference(currentDuration);
    // }
  }

  @override
  Widget build(BuildContext context) {
    print('hey');

    // print(inputDuration.second +
    //     inputDuration.minute * 60 +
    //     inputDuration.hour * 60 * 60);
    // print(currentDuration.second);
    // remainingTime=rem;
    print(remainingTime);
    // based on remainingTime.. (+ or -) resturn the scaffold

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("target-${displayhr}:${displaymin}:${displaysec}"),
          CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                remainingTime.inSeconds * 1000,
            // DateTime.now().millisecondsSinceEpoch + 9000,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            onEnd: () {
              // print("hihr");
              setState(() {
                // inputDuration.add(Duration(days: 1));

                hrInput = 23;
                minInput = 59;
                secInput = 59;
                remainingTime = Duration(hours: 23, minutes: 59, seconds: 59);
                // days = days * 60 * 60 - (remainingTime.inSeconds);
                // days = (days / 60) as int;

                // secInput = 0;
                // hrInput = 24;
                // minInput = 0;

                // hr = DateTime.now().hour;
                // min = DateTime.now().minute;
                // sec = DateTime.now().second;
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                // audioInput.play(AssetSource("/audios/audio.wav"));
              },
              child: Text("play"))
        ],
      )),
    );
  }
}
