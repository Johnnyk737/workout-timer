import 'package:flutter/material.dart';
import 'package:workout_timer/custom/custom_time_picker.dart';
import 'package:flutter_picker/flutter_picker.dart';

class WorkoutSetting extends StatefulWidget {
  WorkoutSetting({Key key, context, this.workout});

  final Map workout; 

  @override
  _WorkoutSettingState createState() => _WorkoutSettingState();

}

class _WorkoutSettingState extends State<WorkoutSetting> {
  // TextEditingController _setsTextEditController;
  // TextEditingController _roundsTextEditController;
  int sets;
  int rounds;
  MinutesSeconds workSeconds;
  MinutesSeconds restSeconds;

  void initState() {
    super.initState();
    sets = 0;
    rounds = 0;
    workSeconds = MinutesSeconds();
    restSeconds = MinutesSeconds();
    // _setsTextEditController = TextEditingController();
    // _roundsTextEditController = TextEditingController();

    // _setsTextEditController.addListener(_setsControllerState);
    // _roundsTextEditController.addListener(_roundsControllerState);
  }

  // void _setsControllerState() {
  //   print("sets: ${_setsTextEditController.text}");
    
  //   int _intSets = 0;
  //   if (_setsTextEditController.text.isNotEmpty) {
  //     try {
  //       _intSets = int.parse(_setsTextEditController.text);
  //       setState(() {
  //         sets = _intSets;
  //       });
  //     } catch(error) {
  //       print(error);
  //       _setsTextEditController.text = '';
  //     }
  //   }
  // }
  
  // void _roundsControllerState() {
  //   print("rounds: ${_roundsTextEditController.text}");

  //   int _intRounds = 0;
  //   if (_roundsTextEditController.text.isNotEmpty) {
  //     try {
  //       _intRounds = int.parse(_roundsTextEditController.text);
  //       setState(() {
  //         rounds = _intRounds;
  //       });
  //     } catch(error) {
  //       print(error);
  //       _roundsTextEditController.text = '';
  //     }
  //   }
  // }

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

  void _setWorkSeconds(List workTime) {
    // print(workTime.toString());

    setState(() {
      // workSeconds = MinutesSeconds(workTime[0], workTime[1]);
      workSeconds.minutes = workTime[0];
      workSeconds.seconds = workTime[1];
    });
    // print(workSeconds.toString());
  }

  void _setRestSeconds(List restTime) {
    // print(restTime.toString());

    setState(() {
      // restSeconds = MinutesSeconds(restTime[0], restTime[1]);
      restSeconds.minutes = restTime[0];
      restSeconds.seconds = restTime[1];
    });
    // print(restSeconds.toString());
  }

  void dispose() {
    // _setsTextEditController.clear();
    // _roundsTextEditController.clear();
    // _setsTextEditController.dispose();
    // _roundsTextEditController.dispose();
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
                  child: Text("Workout Setting",
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
                  // color: Colors.yellowAccent,
                  child: Text("Sets",
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
                          // color: Colors.yellow,
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.remove_circle_outline,
                              semanticLabel: "Subtract Set",
                              size: 48.0,),
                            onTap: () {
                              print("tapped subtract set");
                              _subtractSet();
                              print(sets);
                            },
                          )
                        ),
                      ]
                    ),
                    Container(
                      // height: 100.0,
                      // width: 350.0,
                      child: Text(sets.toString(),
                        style: TextStyle(
                          fontSize: 46.0
                        ),
                      )
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          // color: Colors.yellow,
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.add_circle_outline,
                              semanticLabel: "Add Set",
                              size: 48.0,),
                            onTap: () {
                              print("tapped add set");
                              _addSet();
                              print(sets);
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
                  // color: Colors.yellowAccent,
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("Rounds",
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
                          // color: Colors.yellow,
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.remove_circle_outline,
                              semanticLabel: "Subtract Round",
                              size: 48.0,),
                            onTap: () {
                              print("tapped subtract round");
                              _subtractRound();
                              print(rounds);
                            },
                          )
                        ),
                      ]
                    ),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          // color: Colors.cyan,
                          height: 75.0,
                          // width: 250.0,
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
                          // color: Colors.yellow,
                          height: 75.0,
                          width: 75.0,
                          child: GestureDetector(
                            child: Icon(Icons.add_circle_outline,
                              semanticLabel: "Add Round",
                              size: 48.0,),
                            onTap: () {
                              print("tapped add round");
                              _addRound();
                              print(rounds);
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
                  child: Text("Work Time",
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: GestureDetector(
                    child: Text(workSeconds.build(),
                      style: TextStyle(
                        fontSize: 46.0
                      ),
                    ),
                    onTap: () => showPickerNumber(context, workSeconds, _setWorkSeconds)
                  )
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text("Rest Time",
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: GestureDetector(
                    child: Text(restSeconds.build(),
                      style: TextStyle(
                        fontSize: 46.0
                      ),
                    ),
                    onTap: () => showPickerNumber(context, restSeconds, _setRestSeconds)
                  )
                ),
              ],
            ),
          ]
        )
      ),
      bottomNavigationBar: new Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              // flex: 2,
              margin: EdgeInsets.all(10.0),
              width: 175.0,
              height: 50.0,
              child: FlatButton(
                color: Colors.black26,
                child: Text("Back"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                onPressed: () {
                  Navigator.pop(context);
                }, 
              )
            ),
            Container(
              // flex: 2, 
              // padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(10.0),
              width: 175.0,
              height: 50.0,
              child: FlatButton(
                color: Colors.blueAccent,
                textColor: Colors.white,
                child: Text("Start"),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                onPressed: () {},
              )
            )
          ],
        ),
      )
    );
  }

  void showPickerNumber(BuildContext context, MinutesSeconds currTime, setter) {
    new Picker(
        looping: true,
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(
            initValue: currTime.minutes,
            begin: 0, 
            end: 59,
            onFormatValue: (v) {
              return v < 10 ? "0$v" : "$v";
            }
          ),
          NumberPickerColumn(
            initValue: currTime.seconds,
            begin: 0, 
            end: 59,
            onFormatValue: (v) {
              return v < 10 ? "0$v" : "$v";
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
        title: new Text("Please Select"),
        onConfirm: (Picker picker, List value) {
          setter(value);
        }
    ).showDialog(context);
  }
}

class MinutesSeconds {
  int minutes;
  int seconds;

  MinutesSeconds() {
    this.minutes = 0;
    this.seconds = 0;
  }

  MinutesSeconds.withTime(int minutes, int seconds) {
    this.minutes = minutes;
    this.seconds = seconds;
  }

  @override
  String toString() {
    return "minutes: ${this.minutes}, seconds: ${this.seconds}";
  }

    String digits(int index, int pad) {
      return '$index'.padLeft(pad, '0');
    }

  String build() {
    String minutes = this.digits(this.minutes, 2);
    String seconds = this.digits(this.seconds, 2);
    return "$minutes:$seconds";
  }
}
