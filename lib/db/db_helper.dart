import 'package:sqflite/sqflite.dart';
import 'package:workout_timer/db/models/workouts.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

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

  // make this a singleton class
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    
    _db = await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, dbName);

    // TODO: take this out later
    // Delete the database
    await deleteDatabase(path);

    try {
      await Directory(dbPath).create(recursive: true);
    } catch (_) {}

    
    final db = openDatabase(path, 
                            onConfigure: _onConfigure, 
                            version: 1, 
                            onCreate: _onCreate);
    
    return db;
  }

  void _onConfigure(Database db) async {
    null;
  }

  void _onCreate(Database db, int version) async {
    // temporary
    // await db.execute('DROP TABLE $tableWorkout');
    
    await db.execute(
      'CREATE TABLE $tableWorkout ($colId INTEGER PRIMARY KEY, $colSets INTEGER, $colRounds INTEGER, $colWorkTime INTEGER, $colRestTime INTEGER, $colDisplay TEXT, $colType INTEGER)');
    
    // preload data from files
    var presetWorkout = await _loadPresets() as List<Workout>;
    var batch = db.batch();
    for (var workout in presetWorkout) {
      await batch.insert(tableWorkout, workout.toMap());
    }
    await batch.commit(noResult: true);
  }

  Future<List> getWorkoutById(int id) async {
    var db = await instance.database;

    var row = db.query(tableWorkout, where: '$colId = ?', whereArgs: [id]);
    return row;
  }

  Future<List> getWorkouts() async {
    var db = await instance.database;

    final workouts = await db.rawQuery('SELECT * FROM $tableWorkout');

    return _generateListWithId(workouts);
  }

  Future<int> insertWorkout(Workout workout) async {
    var db = await instance.database;

    var row = db.insert(tableWorkout, 
                        workout.toMap(), 
                        conflictAlgorithm: ConflictAlgorithm.abort);
    return row;
  }

  Future<List> getPresets() async {
    var db = await instance.database;

    final presets = await db.query(tableWorkout, 
                                   where: '$colType = ?', 
                                   whereArgs: [0]);

    return _generateListWithId(presets);
  }

  List _generateListWithId(dynamic list) {
    return List.generate(list.length as int, (i) {
      return Workout.withId(
        id: list[i]['id'] as int,
        sets: list[i]['sets'] as int,
        rounds: list[i]['rounds'] as int,
        workTime: list[i]['workTime'] as int,
        restTime: list[i]['restTime'] as int,
        display: list[i]['display'].toString(),
        type: list[i]['type'] as int
      );
    });
  }

  List<Workout> _generateList(dynamic list, {int type = 1}) {
    return List.generate(list.length as int, (i) {
      return Workout(
        sets: list[i]['sets'] as int,
        rounds: list[i]['rounds'] as int,
        workTime: list[i]['workTime'] as int,
        restTime: list[i]['restTime'] as int,
        display: list[i]['display'].toString(),
        type: type
      );
    });
  }

  ///
  /// Gets the presets from the assets and preloads them to the database
  ///
  Future<List> _loadPresets() async {
    var presetsJson = await rootBundle.loadString('assets/presets.json');

    var _presets = List<Map<String, dynamic>>.from(jsonDecode(presetsJson) as List);
    var presetWorkout = _generateList(_presets, type:0);
    return presetWorkout;
  }

}
