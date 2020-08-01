import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workout_timer/timer/timer.dart';
import 'package:workout_timer/workout_setting.dart';
import 'package:flutter/services.dart' show rootBundle, SystemChannels;

import 'db/db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Workout Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Map> _prevWorkouts = [];
  List<Map> _presets = [];

  // DbHelper db = DbHelper();
  // var dbFuture = db.initializeDb();

  @override
  void initState() {
    super.initState();
    loadTestData();
    loadPresets();

  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      
    });
  }

  Future loadPresets() async {
    String presetsJson = await rootBundle.loadString('assets/presets.json');

    print("Setting presets");
    setState(() {
      _presets = List<Map>.from(jsonDecode(presetsJson) as List);
    });
  }

  Future loadTestData() async {
    String dataJson = await rootBundle.loadString('assets/previous_workouts.json');

    print("Setting prev workouts");
    setState(() {
      _prevWorkouts = List<Map>.from(jsonDecode(dataJson) as List);
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
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
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container( 
                    // color: Colors.lightBlueAccent,
                    padding: EdgeInsets.all(5.0),
                    width: 200.0,
                    height: 50.0,
                    child: FlatButton(
                      color: Colors.blueAccent,
                      textColor: Colors.black,
                      // splashColor: Colors.yellow,f
                      // highlightElevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      child: Text("New Workout"),
                      onPressed: () => {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WorkoutSetting(context: context)))
                      }
                    ),
                  )
                ]
              ),
              Row(
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
                      child: Text("Previous Workouts"),
                      onPressed: () => print("Previous Workout Button pressed")
                    )
                  )
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                        child: Text("Preset Workouts", 
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
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // Public: Returns a Container of previous workouts
  // Widget buildPreviousWorkouts(List prevWorkouts) {
  //   return null;
  //   // String pre = '[{"sets":[{"rounds":3,"seconds":30,"restBetweenRounds":10},{"rounds":3,"seconds":30,"restBetweenRounds":10},{"rounds":3,"seconds":30,"restBetweenRounds":10}],"restBetweenSets":30,"alternatingSets":false},{"sets":[{"rounds":3,"seconds":40,"restBetweenRounds":10},{"rounds":3,"seconds":40,"restBetweenRounds":10}],"restBetweenSets":30,"alternatingSets":false},{"sets":[{"rounds":3,"seconds":30,"restBetweenRounds":10},{"rounds":3,"seconds":40,"restBetweenRounds":10},{"rounds":3,"seconds":50,"restBetweenRounds":10},{"rounds":3,"seconds":40,"restBetweenRounds":10},{"rounds":3,"seconds":30,"restBetweenRounds":10}],"restBetweenSets":30,"alternatingSets":true},{"sets":[{"rounds":5,"seconds":30,"restBetweenRounds":10},{"rounds":5,"seconds":40,"restBetweenRounds":10},{"rounds":5,"seconds":30,"restBetweenRounds":10}],"restBetweenSets":30,"alternatingSets":true}]';
  // }
  
  // Public: Returns a Container of presets
  // Each row will be clickable and load into the workout screen
  // The text should display like # sets, # rounds (seconds per round)
  // ex. 
  //    2 sets, 3 rounds (30/30)
  //    5 sets, 3 rounds (30/40/40/30/20)
  Widget buildPresets(presets) {
    // print(presets);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: presets.map<Widget>((data)=>
      // I would like to have the container and divider return for each loop of the map
      // so it looks like Column(container, divider, container, divider, etc)
      new Column(
        children: <Widget>[
          Container(
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(data["display"])
              ),
              onTap: () => {
                    print("Tapped ${data['display']}"),
                    // print(context),
                    // print(data),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WorkoutSetting(context: context, workout: data)))
                  },
            )
          ),
          Container(
            // padding: EdgeInsets.only(right: 20.0, left: 20.0),
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
