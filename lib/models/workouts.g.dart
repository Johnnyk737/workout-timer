// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workouts _$WorkoutsFromJson(Map<String, dynamic> json) {
  return Workouts(
    json['sets'] as int,
    json['rounds'] as int,
    json['workTime'] as int,
    json['restTime'] as int,
    json['display'] as String,
    json['type'] as int,
    json['restBetweenSets'] as int,
    json['alternatingSets'] as bool,
  );
}

Map<String, dynamic> _$WorkoutsToJson(Workouts instance) => <String, dynamic>{
      'sets': instance.sets,
      'rounds': instance.rounds,
      'workTime': instance.workTime,
      'restTime': instance.restTime,
      'display': instance.display,
      'type': instance.type,
      'restBetweenSets': instance.restBetweenSets,
      'alternatingSets': instance.alternatingSets,
    };
