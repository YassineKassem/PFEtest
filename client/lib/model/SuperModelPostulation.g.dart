// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelPostulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelPostulation _$SuperModelPostulationFromJson(
        Map<String, dynamic> json) =>
    SuperModelPostulation(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => postulation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelPostulationToJson(
        SuperModelPostulation instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
