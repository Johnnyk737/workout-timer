import 'package:flutter/material.dart';

/*
  Class to handle the timer display and functionality
*/
class Timer extends StatefulWidget {
  Timer({Key key, context, this.workout});

  // This will be a map of the settings.
  // Should include sets, rounds, worktime and resttime data
  final Map<String, dynamic> workout; 
  
  @override
  _TimerState createState() => _TimerState(this.workout);
}

class _TimerState extends State<Timer> {
  Map<String, dynamic> workout;
  int totalWorkTime = 0;
  int secondsOffset = 0;
  int minutesOffset = 0;
  int countDown = 00;
  String seconds = '';
  String minutes = '';

  _TimerState(this.workout);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    seconds = this.workout['workTime'].seconds.toString();
    minutes = this.workout['workTime'].minutes.toString();
    totalWorkTime = this.workout['workTime'].getTotalSeconds() as int;
  }


  void startCountdown() async {
    // TODO: Need to make sure that the start button isn't pressed more than once
    // or make it so that if the start button is pressed after it's running, don't
    // run another time since this function is async.
    for (var i = this.totalWorkTime; i >= 0; i--) {
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
                  Navigator.pop(context);
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
                onPressed: null
              )
            )
          ],
        ),
      )
    );
  }
}
