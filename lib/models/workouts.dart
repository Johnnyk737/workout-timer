import 'package:json_annotation/json_annotation.dart';

part 'workouts.g.dart';

@JsonSerializable()
class Workouts {
  Workouts(
    this.sets, 
    this.rounds, 
    this.workTime, 
    this.restTime, 
    this.display, 
    this.type,
    this.restBetweenSets,
    this.alternatingSets);
  
  final int sets;
  final int rounds;
  final int workTime;
  final int restTime;
  final String display;
  final int type;
  final int restBetweenSets;
  final bool alternatingSets;

  factory Workouts.fromJson(Map<String, dynamic> json) => _$WorkoutsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$WorkoutsFromJson`.
  Map<String, dynamic> toJson() => _$WorkoutsToJson(this);
}
