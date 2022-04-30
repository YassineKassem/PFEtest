// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendationOffre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

recommendationOffre _$recommendationOffreFromJson(Map<String, dynamic> json) =>
    recommendationOffre(
      id: json['_id'] as String?,
      score: (json['score'] as num?)?.toDouble(),
      offreId: json['offreId'],
      etudiantId: json['etudiantId'],
    );

Map<String, dynamic> _$recommendationOffreToJson(
        recommendationOffre instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'score': instance.score,
      'offreId': instance.offreId,
      'etudiantId': instance.etudiantId,
    };
