// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

recommendation _$recommendationFromJson(Map<String, dynamic> json) =>
    recommendation(
      id: json['_id'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      postulationId: json['postulationId'],
      societeId: json['societeId'],
    );

Map<String, dynamic> _$recommendationToJson(recommendation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'score': instance.score,
      'postulationId': instance.postulationId,
      'societeId': instance.societeId,
    };
