/*
  Class to handle the timer display and functionality
*/

import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  // It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  
  @override
  _TimerState createState() => new _TimerState();
}

class _TimerState extends State<Timer> {
  int totalWorkTime = 0;
  int secondsOffset = 0;
  int minutesOffset = 0;
  int countDown = 00;
  String seconds = '';
  String minutes = '';


  void startCountdown() async {
    // TODO: Need to make sure that the start button isn't pressed more than once
    // or make it so that if the start button is pressed after it's running, don't
    // run another time since this function is async.
    for (var i = totalWorkTime; i >= 0; i--) {
      // need to wait 1 second before continuing
      secondsOffset = totalWorkTime % 60;
      setState(() {
        // countDown = i;
        seconds = countDown.toString().padLeft(2, '0');
      });
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: Text(countDown.toString().padLeft(2, '0'), 
          style: TextStyle(fontSize: 64),)
      )
    );
  }
}
