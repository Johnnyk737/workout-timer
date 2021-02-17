import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:workout_timer/pages/timer/workout_timer.dart';
import '../db/db_helper.dart';
import '../db/models/workouts.dart';

class WorkoutSetting extends StatefulWidget {
  WorkoutSetting({Key key, context, this.workout});

  final Map<String, dynamic> workout; 

  @override
  _WorkoutSettingState createState() => _WorkoutSettingState(this.workout);
}

class _WorkoutSettingState extends State<WorkoutSetting> {

  _WorkoutSettingState(this.workout);
  int sets;
  int rounds;
  MinutesSeconds workTime;
  MinutesSeconds restTime;
  Map<String, dynamic> workout;

  DbHelper db = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    sets = (workout != null ? workout['sets'] : 1) as int;
    rounds = (workout != null ? workout['rounds'] : 1) as int;
    workTime = workout != null ? MinutesSeconds.asList(_getMinutesSeconds(workout['workTime'] as int)) : MinutesSeconds();
    restTime = workout != null ? MinutesSeconds.asList(_getMinutesSeconds(workout['restTime'] as int)) : MinutesSeconds();
  }

  // From a number of seconds, get minutes and remaining seconds
  // Returns array of minutes and seconds
  // ex. seconds = 61, return [1,1]
  List<int> _getMinutesSeconds(int seconds) {
    var minutes = (seconds / 60).floor();
    var remainder = (seconds % 60);
    return [minutes, remainder];
  }

  Map<String, dynamic> _buildSettingsObj() {
    return ({'sets': sets, 'rounds': rounds, 'workTime': workTime, 'restTime': restTime});
  }

  void _addSet() {
    // TODO: set max
    setState(() {
      sets += 1;
    });
  }

  void _subtractSet() {
    if (sets > 0) {
      setState(() {
        sets -= 1;
      });
    }
  }

  void _addRound() {
    // TODO: set max
    setState(() {
      rounds += 1;
    });
  }

  void _subtractRound() {
    if (rounds > 0) {
      setState(() {
        rounds -= 1;
      });
    }
  }

  void _setWorkSeconds(List<int> workTimeList) {
    setState(() {
      workTime.minutes = workTimeList[0];
      workTime.seconds = workTimeList[1];
    });
  }

  void _setRestSeconds(List<int> restTimeList) {
    setState(() {
      restTime.minutes = restTimeList[0];
      restTime.seconds = restTimeList[1];
    });
  }

  bool _areSettingsValid() {
    if (sets > 0 && rounds > 0 && 
        (workTime.minutes > 0 || workTime.seconds > 0)) {
      return true;
    }
    return false;
  }

  void saveWorkout() async {
    var display = '${this.sets} ${this.sets > 1 ? 'sets' : 'set'}, ${this.rounds} ${this.rounds > 1 ? 'rounds' : 'round'}';
    var workout = Workout(sets: this.sets,
                          rounds: this.rounds,
                          workTime: this.workTime.getTotalSeconds(),
                          restTime: this.restTime.getTotalSeconds(),
                          display: display,
                          type: 1
                          );

    await db.insertWorkout(workout);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(// Title row
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  child: Text('Workout Setting',
                    style: TextStyle(
                      fontSize: 36.0
                    ),
                  )
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Text('Sets',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Row( // number of sets
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.remove_circle_outline,
                              semanticLabel: 'Subtract Set',
                              size: 48.0,),
                            onTap: () {
                              _subtractSet();
                            },
                          )
                        ),
                      ]
                    ),
                    Container(
                      child: Text(sets.toString(),
                        style: TextStyle(
                          fontSize: 46.0
                        ),
                      )
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.add_circle_outline,
                              semanticLabel: 'Add Set',
                              size: 48.0,),
                            onTap: () {
                              _addSet();
                            },
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            Column( // rounds
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('Rounds',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Row(// number of rounds
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.remove_circle_outline,
                              semanticLabel: 'Subtract Round',
                              size: 48.0,),
                            onTap: () {
                              _subtractRound();
                            },
                          )
                        ),
                      ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          alignment: Alignment(0.0, 0.0),
                          child: Text(rounds.toString(),
                            style: TextStyle(
                              fontSize: 46.0
                            ),
                          )
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.add_circle_outline,
                              semanticLabel: 'Add Round',
                              size: 48.0,),
                            onTap: () {
                              _addRound();
                            },
                          )
                        ),
                      ],
                    )
                  ],
                ),
              ]
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('Work Time',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: GestureDetector(
                    child: Text(workTime.build(),
                      style: TextStyle(
                        fontSize: 46.0
                      ),
                    ),
                    onTap: () => showPickerNumber(context, workTime, _setWorkSeconds)
                  )
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Rest Time',
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: GestureDetector(
                    child: Text(restTime.build(),
                      style: TextStyle(
                        fontSize: 46.0
                      ),
                    ),
                    onTap: () => showPickerNumber(context, restTime, _setRestSeconds)
                  )
                ),
              ],
            ),
          ]
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
                }, 
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
                onPressed: _areSettingsValid() ? () {
                  saveWorkout();
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WorkoutTimer(context: context, workout: _buildSettingsObj())
                    ));
                  } : null
              )
            )
          ],
        ),
      )
    );
  }

  void showPickerNumber(BuildContext context, MinutesSeconds currTime, setter) {
    Picker(
      looping: true,
      adapter: NumberPickerAdapter(data: [
        NumberPickerColumn(
          initValue: currTime.minutes,
          begin: 0, 
          end: 59,
          onFormatValue: (v) {
            return v < 10 ? '0$v' : '$v';
          }
        ),
        NumberPickerColumn(
          initValue: currTime.seconds,
          begin: 0, 
          end: 59,
          onFormatValue: (v) {
            return v < 10 ? '0$v' : '$v';
          }
        ),
      ]),
      delimiter: [
        PickerDelimiter(child: Container(
          width: 30.0,
          alignment: Alignment.center,
          child: Text(':',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ))
      ],
      hideHeader: true,
      title: Text('Please Select'),
      onConfirm: (Picker picker, List value) {
        setter(value);
      }
    ).showDialog(context);
  }
}

class MinutesSeconds {
  int minutes;
  int seconds;

  MinutesSeconds() : this.withTime(0, 0);

  MinutesSeconds.withTime(int minutes, int seconds) {
    this.minutes = minutes;
    this.seconds = seconds;
  }
  
  MinutesSeconds.asList(List<int> time) {
    this.minutes = time[0];
    this.seconds = time[1];
  }

  @override
  String toString() {
    return 'minutes: ${this.minutes}, seconds: ${this.seconds}';
  }

  String digits(int index, int pad) {
    return '$index'.padLeft(pad, '0');
  }

  int getTotalSeconds() {
    return (this.minutes * 60) + this.seconds;
  }

  String build() {
    var min = this.digits(this.minutes, 2);
    var sec = this.digits(this.seconds, 2);
    return '$min:$sec';
  }
}
