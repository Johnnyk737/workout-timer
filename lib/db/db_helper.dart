import 'package:sqflite/sqflite.dart';
import 'package:workout_timer/db/models/workouts.dart';

/// DbHelper
/// Will be used to do CRUD operations on the database so we aren't manipulating the database directly
class DbHelper {
  final String tableWorkout = 'workout';
  final String colId = '_id';
  final String colSets = 'sets'; // int
  final String colRounds = 'rounds'; // int
  final String colWorkTime = 'workTime'; // int
  final String colRestTime = 'restTime'; // int
  final String colDisplay = 'display'; // String
  final String colType = 'type'; // 0 - preset, 1 - previous workout
  final String colRestBetweenSets = 'restBetweenSets'; // int
  final String colAlternatingSets = 'alternatingSets'; // boolean
}
