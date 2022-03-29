// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offreStageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stage _$StageFromJson(Map<String, dynamic> json) => Stage(
      username: json['username'] as String?,
      nomOffre: json['nomOffre'] as String?,
      descriptionOffre: json['descriptionOffre'] as String?,
      localisation: json['localisation'] as String?,
      dateExpiration: json['dateExpiration'] == null
          ? null
          : DateTime.parse(json['dateExpiration'] as String),
      duree: json['duree'] as String?,
      motClee: (json['motClee'] as List<dynamic>?)
          ?.map((e) => MotCle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StageToJson(Stage instance) => <String, dynamic>{
      'username': instance.username,
      'nomOffre': instance.nomOffre,
      'descriptionOffre': instance.descriptionOffre,
      'localisation': instance.localisation,
      'dateExpiration': instance.dateExpiration?.toIso8601String(),
      'duree': instance.duree,
      'motClee': instance.motClee,
    };
