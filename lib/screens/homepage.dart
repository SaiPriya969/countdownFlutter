import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late CountdownTimerController controller;
  int hr = DateTime.now().hour;
  int min = DateTime.now().minute;
  int sec = DateTime.now().second;
  int hrInput = 16;
  int minInput = 6;
  int secInput = 00;
  int displayhr = 16;
  int displaymin = 6;
  int displaysec = 00;
  int days = 0;

  @override
  Widget build(BuildContext context) {
    DateTime currentDuration =
        DateTime.now().add(Duration(hours: hr, minutes: min, seconds: sec));
    DateTime inputDuration = DateTime.now().add(Duration(
        days: days, hours: hrInput, minutes: minInput, seconds: secInput));
    // int remainingtime = inputDuration.inSeconds - currentDuration.inSeconds;

    Duration remainingtime = inputDuration.difference(currentDuration);
    print('hey');

    // print(inputDuration.second +
    //     inputDuration.minute * 60 +
    //     inputDuration.hour * 60 * 60);
    // print(currentDuration.second);
    print(remainingtime);
    // based on remainingtime.. (+ or -) resturn the scaffold

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text("target-${displayhr}:${displaymin}:${displaysec}"),
          CountdownTimer(
            endTime: DateTime.now().millisecondsSinceEpoch +
                remainingtime.inSeconds * 1000,
            // DateTime.now().millisecondsSinceEpoch + 9000,
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            onEnd: () {
              print("hihr");
              setState(() {
                // inputDuration.add(Duration(days: 1));

                days = (days + 1);
                days = days * 60 * 60 - (remainingtime.inSeconds);
                days = (days / 60) as int;

                // secInput = 0;
                // hrInput = 24;
                // minInput = 0;

                // hr = DateTime.now().hour;
                // min = DateTime.now().minute;
                // sec = DateTime.now().second;
              });
            },
          )
        ],
      )),
    );
  }
}
