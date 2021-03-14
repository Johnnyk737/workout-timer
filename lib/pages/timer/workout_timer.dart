import 'package:flutter/material.dart';
import 'dart:async' ;
import 'package:flutter/foundation.dart';

/*
  Class to handle the timer display and functionality
*/
class WorkoutTimer extends StatefulWidget {
  WorkoutTimer({
    Key key, 
    context, 
    @required this.workout}) : assert(workout != null), 
    super(key: key);

  // This will be a map of the settings.
  // Should include sets, rounds, worktime and resttime data
  final Map<String, dynamic> workout; 
  
  @override
  _WorkoutTimerState createState() => _WorkoutTimerState(this.workout);
}

enum Activity {
  WORKOUT,
  REST,
  DONE
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  Map<String, dynamic> workout;
  int _sets;
  int _rounds;
  int _totalTime = 0;
  int _restTime;
  int _workTime;
  Timer _timer;
  bool _isButtonEnabled = true;
  Activity activityState;

  _WorkoutTimerState(this.workout);

  @override
  void initState() {
    super.initState();
    _sets = this.workout['sets'] as int;
    _rounds = this.workout['rounds'] as int;
    _restTime = this.workout['restTime'].getTotalSeconds() as int;
    _workTime = this.workout['workTime'].getTotalSeconds() as int;
    activityState = Activity.WORKOUT;
    _totalTime = _workTime;
  }
  
  /// switches between rest and work, decrements set and rounds, and starts timer
  void switchActivity() {
    if (activityState == Activity.REST) {
      print('switching activity to workout');
      setState(() {
        _timer = null;
        activityState = Activity.WORKOUT;
        _totalTime = this._workTime;
      });
    } else if (activityState == Activity.WORKOUT) {
      setState(() {
        _timer = null;
        this._rounds--;
        if (this._sets == 1 && this._rounds == 0) {
          print('Workout done');
          activityState = Activity.DONE;
        } else if (this._rounds == 0 && this._sets > 0) {
          print('switching activity to rest');
          this._sets--;
          this._rounds = this.workout['rounds'] as int;
          activityState = Activity.REST;
          _totalTime = this._restTime;
        } else {
          print('switching activity to rest');
          activityState = Activity.REST;
          _totalTime = this._restTime;
        }
      });
    }
    if (activityState == Activity.DONE) return;
    startTimer();
  }

  void startTimer() async {
    // Disable the start button on click because there is a delay between button press and _timer.isActive
    setState(() {
      _isButtonEnabled = false;
    });
    print('Timer started');

    _timer = Timer.periodic(
      Duration(seconds: 1), 
      (Timer timer) { 
        if (_totalTime == 0) {
          print('Done');
          setState(() {
            timer.cancel();
          });
          this.switchActivity();
          // restartTimer();
        } else {
          setState(() {
            _totalTime--;
          });
        }
      });
  }

  /// This method will serve to pause the timer
  void stopTimer() async {
    print('Timer paused');
    _timer.cancel();
    _timer = null;
    setState(() {
    });
  }

  void restartTimer() async {
    print('Timer restarted');
    setState(() {
      _totalTime = this._workTime;
      _sets = this.workout['sets'] as int;
      _rounds = this.workout['rounds'] as int;
      activityState = Activity.WORKOUT;
      _isButtonEnabled = true;
        
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
      }
    });
  }

  String getDisplay() {
    var min = (_totalTime / 60).floor();
    var sec = (_totalTime % 60);

    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: 400,
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Sets: $_sets',
                      style: TextStyle(fontSize: 24),
                    ),
                    Text('Rounds: $_rounds',
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
                Column(
                  
                  children: [
                    Center(
                      child: Text(this.activityState != null ? describeEnum(this.activityState) : 'WORKOUT',
                        style: TextStyle(fontSize: 24),
                      )
                    ),
                    Center(
                      child: Text(this.getDisplay(), 
                        style: TextStyle(fontSize: 64),
                      ),
                    )
                  ],
                )
              ],
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
                child: Text('Restart'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                onPressed: () => restartTimer(),
                // onPressed: () {
                //   Navigator.pop(context);
                // }
              )
            ),
            _timer != null ?
              stopButton() : startButton(),
          ],
        ),
      )
    );
  }

  Widget startButton() {
    return Container(
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
        onPressed: _isButtonEnabled ? () => startTimer() : null
      )
    );
  }

  Widget stopButton() {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 175.0,
      height: 50.0,
      child: FlatButton(
        color: Colors.redAccent,
        textColor: Colors.black,
        disabledColor: Colors.red[100],
        disabledTextColor: Colors.black54,
        child: Text('Stop'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        onPressed: () => this.stopTimer()
      )
    );
  }
}
