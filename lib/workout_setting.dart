import 'package:flutter/material.dart';

class WorkoutSetting extends StatefulWidget {
  WorkoutSetting({Key key, context, this.workout});

  final Map workout; 

  @override
  _WorkoutSettingState createState() => _WorkoutSettingState();

}

class _WorkoutSettingState extends State<WorkoutSetting> {
  TextEditingController _setsTextEditController;
  TextEditingController _roundsTextEditController;
  int sets = 0;
  int rounds = 0;

  void initState() {
    super.initState();
    _setsTextEditController = TextEditingController();
    _roundsTextEditController = TextEditingController();
    _setsTextEditController.clear();
    _roundsTextEditController.clear();

    _setsTextEditController.addListener(_setsControllerState);
    _roundsTextEditController.addListener(_roundsControllerState);
  }

  void _setsControllerState() {
    print("sets: ${_setsTextEditController.text}");
    
    int _intSets = 0;
    if (_setsTextEditController.text.isNotEmpty) {
      try {
        _intSets = int.parse(_setsTextEditController.text);
        setState(() {
          sets = _intSets;
        });
      } catch(error) {
        print(error);
        _setsTextEditController.text = '';
      }
    }
  }
  
  void _roundsControllerState() {
    print("rounds: ${_roundsTextEditController.text}");

    int _intRounds = 0;
    if (_roundsTextEditController.text.isNotEmpty) {
      try {
        _intRounds = int.parse(_roundsTextEditController.text);
        setState(() {
          rounds = _intRounds;
        });
      } catch(error) {
        print(error);
        _roundsTextEditController.text = '';
      }
    }
  }

  void dispose() {
    _setsTextEditController.dispose();
    _roundsTextEditController.dispose();
    super.dispose();
  }

  String _validateNumberField(String text) {
    if (text.contains(new RegExp(r'[a-zA-Z]'))) {
      // _setsTextEditController.text = '';
      return 'You cannot enter letters';
    }

    return null;
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
            Row( // number of sets
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 350.0,
                  child: TextFormField(
                    controller: _setsTextEditController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Sets",
                      // errorText: _validateNumberField(_setsTextEditController.text)
                    ),
                    autovalidate: true,
                    validator: (String text) => _validateNumberField(text),
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  )
                )
              ],
            ),
            Row(// number of rounds
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100.0,
                  width: 350.0,
                  child: TextFormField(
                    controller: _roundsTextEditController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      hintText: "Rounds",
                      // errorText: _validateNumberField(_setsTextEditController.text)
                    ),
                    autovalidate: true,
                    validator: (String text) => _validateNumberField(text),
                    style: TextStyle(
                      fontSize: 16.0
                    ),
                  )
                )
              ],
            ),
          ]
        )
      )
    );
  }

  // Responsible for building the list of widgets that
  // will handle setting the time per set
  List<Widget> buildSetsList(int sets) {
    List<Widget> setList = [];
    Widget set;
    for (int i = 0; i < sets; i--) {
      set = new Row(
        children: <Widget>[
          Container(
            height: 100.0,
            width: 400.0,
            child: TextFormField(
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixText: "seconds",
              ),
              autovalidate: true,
              validator: (String text) => _validateNumberField(text),
              style: TextStyle(
                fontSize: 16.0
              ),
              onChanged: null,
            )
          )
        ], 
      );
      setList.add(set);
    }

    return setList;
  }
}
