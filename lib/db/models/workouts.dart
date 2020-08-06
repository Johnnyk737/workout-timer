
class Workout {
  int id;
  int sets;
  int rounds;
  int workTime;
  int restTime;
  int restBetweenSets;
  String display;
  bool alternatingSets;
  int type;

  // default constructor
  Workout({this.sets, this.rounds, this.workTime, this.restTime, this.display, this.type});

  // editing ?
  Workout.withId({this.id, this.sets, this.rounds, this.workTime, this.restTime, this.display, this.type});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['sets'] = sets;
    map['rounds'] = rounds;
    map['workTime'] = workTime;
    map['restTime'] = restTime;
    map['display'] = display;
    map['type'] = type;
    // map['restBetweenSets'] = restBetweenSets;
    // map['alternatingSets'] = alternatingSets;

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Workout.fromMap(Map<String, dynamic> map) {
    id = map['id'] as int;
    sets = map['sets'] as int;
    rounds = map['rounds'] as int;
    workTime = map['workTime'] as int;
    restTime = map['restTime'] as int;
    display = map['display'].toString();
    type = map['type'] as int;
    // restBetweenSets = map['restBetweenSets'] as int;
    // alternatingSets = map['alternatingSets'] as bool;
  }
}
