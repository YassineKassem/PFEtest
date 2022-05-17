// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelRecommandationOffre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelRecommandationOffre _$SuperModelRecommandationOffreFromJson(
        Map<String, dynamic> json) =>
    SuperModelRecommandationOffre(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => recommendationOffre.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelRecommandationOffreToJson(
        SuperModelRecommandationOffre instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
