import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:core';

/*
  Class to handle the timer display and functionality
*/
class TimerPage extends StatefulWidget {
  TimerPage({Key key, context, this.workout});

  // This will be a map of the settings.
  // Should include sets, rounds, worktime and resttime data
  final Map<String, dynamic> workout; 
  
  @override
  _TimerPageState createState() => _TimerPageState(this.workout);
}

class _TimerPageState extends State<TimerPage> {
  Map<String, dynamic> workout;
  int totalWorkTime = 0;
  int secondsOffset = 0;
  int minutesOffset = 0;
  int countDownTime = 0;
  String seconds = '';
  String minutes = '';
  bool isPaused = false;
  Capability paused;
  Stopwatch stopwatch = Stopwatch();
  Timer timer;

  _TimerPageState(this.workout);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = this.workout['workTime'].seconds.toString();
    minutes = this.workout['workTime'].minutes.toString();
    totalWorkTime = this.workout['workTime'].getTotalSeconds() as int;
    paused = null;
    start();
  }

  final receivePort = ReceivePort();  
  Isolate _isolate;  
  
  void stop() {  
    receivePort.close();  
    _isolate.kill(priority: Isolate.immediate);  
  }  
  
  // Future<void> start(Duration initialDuration) async { 
  //   if (paused != null) {
  //     _isolate.resume(paused);
      
  //     setState(() {
  //       paused = null;
  //     });
  //   } else {
  //     var map = {  
  //       'port': receivePort.sendPort,  
  //       'initial_duration': initialDuration,  
  //     };  
  //     _isolate = await Isolate.spawn(_entryPoint, map);  
  //     // receivePort.sendPort.send(initialDuration);  
  //   }
  // }  
  
  // static void _entryPoint(Map<String, dynamic> map) async {  
  //   var initialTime = map['initial_duration'];
  //   var port = map['port'];
  //   var current = initialTime.inSeconds as int;
    
  //   while (current >= 0) {

  //     print(current--);
  //     await Future.delayed(Duration(seconds: 1));
      
  //   }
  // }

  void start() {

    // I need to fix this.. I can't truly pause the timer so this doesn't work as it
    // will just continually run. I need a better option.
    timer = Timer.periodic(Duration(milliseconds: 1000), (Timer t) => updateClock());
    
    setState(() {
      isPaused = false;
    });
  }

/// Called each time the time is ticking
  void updateClock() {
    final duration = Duration(minutes: this.workout['workTime'].minutes as int, seconds: this.workout['workTime'].seconds as int);
    
    if (!stopwatch.isRunning && isPaused == false) {
      stopwatch.start();
    }

    // if time is up, stop the timer
    print(stopwatch.elapsed.inMilliseconds.toString() + ' ' + stopwatch.elapsed.inSeconds.toString());
    if (stopwatch.elapsed.inMilliseconds >= duration.inMilliseconds) {
        print('--finished Timer Page--');
        stopwatch.stop();
        timer.cancel();
        stopwatch.reset();
        
        // setState(() {
          
        // });
      return;
    }

    if (isPaused == true) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  void pauseTimer() {
    // var pause = _isolate.pause();
    setState(() {
      isPaused = isPaused == true ? false : true;
    });
  }


  // void startCountdown() async {
  //   // TODO: Need to make sure that the start button isn't pressed more than once
  //   // or make it so that if the start button is pressed after it's running, don't
  //   // run another time since this function is async.

  //   for (var i = this.totalWorkTime; i >= 0; i--) {
  //     // need to wait 1 second before continuing
  //     secondsOffset = totalWorkTime % 60;
  //     setState(() {
  //       // countDown = i;
  //       seconds = countDown.toString().padLeft(2, '0');
  //     });
  //     await Future.delayed(Duration(seconds: 1));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${minutes.padLeft(2, '0')}:${seconds.padLeft(2, '0')}', 
                  style: TextStyle(fontSize: 64),
                )
              ],
            )
          )
        )
      ),
      bottomNavigationBar: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              width: 175.0,
              height: 50.0,
              child: FlatButton(
                color: Colors.black26,
                child: Text('Back'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                onPressed: () {
                  // Navigator.pop(context);
                  pauseTimer();
                }
              )
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 175.0,
              height: 50.0,
              child: FlatButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                disabledColor: Colors.blue[100],
                disabledTextColor: Colors.white,
                child: Text('Start'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                onPressed: () => 
                  start()
              )
            )
          ],
        ),
      )
    );
  }
}
