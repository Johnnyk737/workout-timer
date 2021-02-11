import 'package:flutter/material.dart';
// import 'package:quiver/async.dart';
import 'dart:async' ;
import 'package:provider/provider.dart';

/*
  Class to handle the timer display and functionality
*/
class WorkoutTimer extends StatefulWidget {
  WorkoutTimer({Key key, context, this.workout});

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
  int secondsOffset = 0;
  int minutesOffset = 0;
  int countDown = 00;
  // String _seconds = '';
  // String _minutes = '';
  int _sets;
  int _rounds;
  int _totalTime = 0;
  int _restTime;
  int _workTime;
  int _originalTime;
  // CountdownTimer countdownTimer;
  int _current = 10;
  int _start = 10;
  Timer _timer;
  bool _isButtonEnabled = true;
  bool _isWorking;
  Activity activityState;

  _WorkoutTimerState(this.workout);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _seconds = this.workout['workTime'].seconds.toString();
    // _minutes = this.workout['workTime'].minutes.toString();
    _sets = this.workout['sets'] as int;
    _rounds = this.workout['rounds'] as int;
    _restTime = this.workout['restTime'] as int;
    _workTime = this.workout['workTime'].getTotalSeconds() as int;
    _originalTime = _workTime;
    _totalTime = 65;
  }

  /** 
   * I need to be able to handle calling a timer for the work time, then rest time
   * and then loop through when there is a new round, then a new set until we're done
   * I also need to keep track of when the timer is working and when it's resting
   */ 
  // void startWorkout() {
  // }

// class WorkTime {
  // int _totalTime;
  // int _originalTime;
  // Timer _timer;
  // bool _isDone = false;

  // WorkTime(int totalTime) {
  //   this._totalTime = totalTime;
  //   this._originalTime = totalTime;
  // }
  

  /// switches between rest and work, decrements set and rounds, and starts timer
  void switchActivity() {
    if (activityState == Activity.REST) {
      setState(() {
        activityState = Activity.WORKOUT;
        _totalTime = this._workTime;
      });
    } else if (activityState == Activity.WORKOUT) {
      setState(() {
        this._rounds--;
        if (this._sets == 0 && this._rounds == 0) {
          activityState = Activity.DONE;
        } else if (this._rounds == 0 && this._sets > 0) {
          this._sets--;
          this._rounds = this.workout['rounds'] as int;
          activityState = Activity.REST;
          _totalTime = this._restTime;
        }
      });
    }
    startTimer();
  }

  // int resetTime() {
  //   if (activityState == Activity.REST) {
  //     return this._restTime;
  //   } else {
  //     return this._workTime;
  //   }
  // }

  void startTimer() async {
    // Disable the start button on click because there is a delay between button press and _timer.isActive
    // setState(() {
    //   _isButtonEnabled = false;
    // });
    print('Timer started');

    _timer = Timer.periodic(
      Duration(seconds: 1), 
      (Timer timer) { 
        if (_totalTime == 0) {
          print('Done');
          setState(() {
            timer.cancel();
            // _isDone = true;
            this.switchActivity();
            if (this._sets == 0)
            restartTimer();
            // I need to be able to handle re-creating the timer to start the rest period
          });
        } else {
          setState(() {
            _totalTime--;
          });
        }
      });
  }

  /// This method will serve to pause the timer
  ///
  void stopTimer() async {
    print('Timer paused');
    // setState(() {
    //   _isButtonEnabled = true;
    // });
    _timer.cancel();
    _timer = null;
    // _isDone = true;
  }

  void restartTimer() async {
    print('Timer restarted');
    setState(() {
      _totalTime = this._workTime;
      // _isButtonEnabled = true;
        
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
        child: Center(
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(this.getDisplay(), 
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
        onPressed: () => _isButtonEnabled ? startTimer() : null
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

// class WorkTime {
//   int _totalTime;
//   int _originalTime;
//   Timer _timer;
//   bool _isDone = false;

//   WorkTime(int totalTime) {
//     this._totalTime = totalTime;
//     this._originalTime = totalTime;
//   }

//   int get totalTime => _totalTime;

//   bool get isDone => _isDone;

//   void startTimer() async {
//     // Disable the start button on click because there is a delay between button press and _timer.isActive
//     // setState(() {
//     //   _isButtonEnabled = false;
//     // });
//     print('Timer started');

//     _timer = Timer.periodic(
//       Duration(seconds: 1), 
//       (Timer timer) { 
//         if (_totalTime == 0) {
//           print('Done');
//           // setState(() {
//             timer.cancel();
//             _isDone = true;
//             restartTimer();
//             // I need to be able to handle re-creating the timer to start the rest period
//           // });
//         } else {
//           // setState(() {
//             _totalTime--;
//           // });
//         }
//       });
//   }

//   /// This method will serve to pause the timer
//   ///
//   void stopTimer() async {
//     print('Timer paused');
//     // setState(() {
//     //   _isButtonEnabled = true;
//     // });
//     _timer.cancel();
//     _timer = null;
//     _isDone = true;
//   }

//   void restartTimer() async {
//     print('Timer restarted');
//     // setState(() {
//       _totalTime =_originalTime;
//       // _isButtonEnabled = true;
        
//       if (_timer != null) {
//         _timer.cancel();
//         _timer = null;
//       }
//     // });
//   }

//   String getDisplay() {
//     var min = (_totalTime / 60).floor();
//     var sec = (_totalTime % 60);

//     return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
//   }
// }
