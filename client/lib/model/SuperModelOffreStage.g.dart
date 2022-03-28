// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelOffreStage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelOffreStage _$SuperModelOffreStageFromJson(
        Map<String, dynamic> json) =>
    SuperModelOffreStage(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelOffreStageToJson(
        SuperModelOffreStage instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
