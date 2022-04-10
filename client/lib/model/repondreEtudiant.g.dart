// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repondreEtudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

repondreEtudiant _$repondreEtudiantFromJson(Map<String, dynamic> json) =>
    repondreEtudiant(
      id: json['_id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      message: json['message'] as String?,
      objet: json['objet'] as String?,
      postulationId: json['postulationId'],
      societeId: json['societeId'],
    );

Map<String, dynamic> _$repondreEtudiantToJson(repondreEtudiant instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'objet': instance.objet,
      'date': instance.date?.toIso8601String(),
      'postulationId': instance.postulationId,
      'societeId': instance.societeId,
    };
