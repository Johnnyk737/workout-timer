import 'package:sqflite/sqflite.dart';
import 'package:workout_timer/db/models/workouts.dart';
import 'package:path/path.dart';
import "dart:async";
import "dart:io";

/// DbHelper
/// Will be used to do CRUD operations on the database so we aren't manipulating the database directly
class DbHelper {
  final String tableWorkout = 'workout';
  final String colId = '_id'; // int
  final String colSets = 'sets'; // int
  final String colRounds = 'rounds'; // int
  final String colWorkTime = 'workTime'; // int
  final String colRestTime = 'restTime'; // int
  final String colDisplay = 'display'; // String
  final String colType = 'type'; // 0 - preset, 1 - previous workout
  final String colRestBetweenSets = 'restBetweenSets'; // int
  final String colAlternatingSets = 'alternatingSets'; // boolean
  final String dbName = 'workout.db';

  Future<Database> _db;

  // // Create a private instance of class
  // static final DbHelper _dbhelper = new DbHelper._internal();

  // // Create an empty private named constructor
  // DbHelper._internal();

  // // use the factory to always return the same instance
  // factory DbHelper() {
  //   return _dbhelper;
  // }

  // static Database _db;

  Future<Database> getDb() {
    _db ??= initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, dbName);

    try {
      await Directory(dbPath).create(recursive: true);
    } catch (_) {}

    
    final db = openDatabase(path, 
                            onConfigure: _onConfigure, 
                            version: 1, 
                            onCreate: _onCreate);
    

    return db;
  }

  _onConfigure(Database db) async {
    null;
  }

  _onCreate(Database db, int version) async {
    // temporary
    await db.execute('DROP TABLE $tableWorkout');
    
    await db.execute(
      'CREATE TABLE $tableWorkout ($colId INTEGER PRIMARY KEY, $colSets INTEGER, $colRounds INTEGER, $colWorkTime INTEGER, $colRestTime INTEGER, $colDisplay TEXT, $colType INTEGER)');
    
    // preload data from files
    await db.insert(tableWorkout, {colSets: 1, colRounds: 1, colWorkTime: 10, colRestTime: 10, colDisplay: "test display", colType: 0});
  }

  Future<List> getWorkoutById(int id) async {
    Database db = await getDb();

    var row = db.query(tableWorkout, where: "$colId = ?", whereArgs: [id]);
    return row;
  }

}
