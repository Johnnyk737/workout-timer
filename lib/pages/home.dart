import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:workout_timer/pages/workout_setting.dart';
import 'package:workout_timer/db/models/workouts.dart';
import 'package:workout_timer/db/db_helper.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {

  List<Workout> _presets = [];

  DbHelper db = DbHelper.instance;

  @override
  void initState() {
    super.initState();
    // loadTestData();
    loadPresets();
  }

  @override
  bool get wantKeepAlive => true;

  // void getRowById(int id) async {
  //   var workouts = await db.getWorkouts();

  //   workouts.forEach((workout) => print(workout));
  // }

  Future loadPresets() async {
    if (_presets.isEmpty) {
      var presets = await db.getPresets();

      print('Setting presets');
      setState(() {
        _presets = List<Workout>.from(presets);
      });
    }
  }

  // Future loadTestData() async {
  //   var dataJson = await rootBundle.loadString('assets/previous_workouts.json');

  //   print('Setting prev workouts');
  //   setState(() {
  //     _prevWorkouts = List<Map>.from(jsonDecode(dataJson) as List);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 50.0),
                        height: 200.0,
                        child: Text(widget.title, 
                          style: TextStyle(
                            fontSize: 48.0,
                          ),
                        ),
                      )
                    ]
                  )
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    width: 200.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.blueAccent,
                      textColor: Colors.black,
                      // highlightElevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      child: Text('New Workout'),
                      onPressed: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutSetting(context: context)))
                      }
                    ),
                  )
                ]
              ),
              Opacity(
                opacity: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 50.0,
                      padding: EdgeInsets.all(5.0),
                      child: FlatButton(
                        color: Colors.black12,
                        textColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: BorderSide(color: Colors.black38, width: 1.0)
                          ),
                        child: Text('Previous Workouts'),
                        onPressed: null
                      )
                    )
                  ]
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: Text('Preset Workouts', 
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                      
                      // buildPreviousWorkouts(_prevWorkouts),
                      Container(
                        child: buildPresets(_presets)
                      )
                    ],
                  )
                ]
              )
            ],
          ),
        )
      );
  }

  // Public: Returns a Container of previous workouts
  // Widget buildPreviousWorkouts(List prevWorkouts) {
  //   return null;
  //   // String pre = '[{'sets':[{'rounds':3,'seconds':30,'restBetweenRounds':10},{'rounds':3,'seconds':30,'restBetweenRounds':10},{'rounds':3,'seconds':30,'restBetweenRounds':10}],'restBetweenSets':30,'alternatingSets':false},{'sets':[{'rounds':3,'seconds':40,'restBetweenRounds':10},{'rounds':3,'seconds':40,'restBetweenRounds':10}],'restBetweenSets':30,'alternatingSets':false},{'sets':[{'rounds':3,'seconds':30,'restBetweenRounds':10},{'rounds':3,'seconds':40,'restBetweenRounds':10},{'rounds':3,'seconds':50,'restBetweenRounds':10},{'rounds':3,'seconds':40,'restBetweenRounds':10},{'rounds':3,'seconds':30,'restBetweenRounds':10}],'restBetweenSets':30,'alternatingSets':true},{'sets':[{'rounds':5,'seconds':30,'restBetweenRounds':10},{'rounds':5,'seconds':40,'restBetweenRounds':10},{'rounds':5,'seconds':30,'restBetweenRounds':10}],'restBetweenSets':30,'alternatingSets':true}]';
  // }
  
  // Public: Returns a Container of presets
  // Each row will be clickable and load into the workout screen
  // The text should display like # sets, # rounds (seconds per round)
  // ex. 
  //    2 sets, 3 rounds (30/30)
  //    5 sets, 3 rounds (30/40/40/30/20)
  Widget buildPresets(List<Workout> presets) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: presets.map<Widget>((Workout data)=>
      // I would like to have the container and divider return for each loop of the map
      // so it looks like Column(container, divider, container, divider, etc)
      Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(data.display.toString())
              ),
              onTap: () => {
                print('Tapped ${data.display.toString()}'),
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutSetting(context: context, workout: data.toMap())))
              },
            )
          ),
          Container(
            width: 250.0,
            child: Divider(
              thickness: 1.0,
              color: Colors.black,
            )
          )
        ]
      )).toList()
    );
  }
}
