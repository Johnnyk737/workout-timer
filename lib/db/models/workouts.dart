
class Workout {
  int _id;
  int _sets;
  int _rounds;
  int _workTime;
  int _restTime;
  int _restBetweenSets;
  String _display;
  bool _alternatingSets;
  int _type;

  // default constructor
  Workout(this._sets, this._rounds, this._workTime, this._restTime, this._display, this._type, [this._alternatingSets, this._restBetweenSets]);

  // editing ?
  Workout.withId(this._id, this._sets, this._rounds, this._workTime, this._restTime, this._display, this._type, [this._alternatingSets, this._restBetweenSets]);


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["sets"] = _sets;
    map["rounds"] = _rounds;
    map["workTime"] = _workTime;
    map["restTime"] = _restTime;
    map["display"] = _display;
    map["type"] = _type;
    map["restBetweenSets"] = _restBetweenSets;
    map["alternatingSets"] = _alternatingSets;

    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Workout.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _sets = map["sets"];
    _rounds = map["rounds"];
    _workTime = map["workTime"];
    _restTime = map["restTime"];
    _display = map["display"];
    _type = map["type"];
    _restBetweenSets = map["restBetweenSets"];
    _alternatingSets = map["alternatingSets"];
  }
}
