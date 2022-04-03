// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

postulation _$postulationFromJson(Map<String, dynamic> json) => postulation(
      etudiant: json['etudiant'],
      offre: json['offre'],
      message: json['message'] as String?,
      objet: json['objet'] as String?,
    );

Map<String, dynamic> _$postulationToJson(postulation instance) =>
    <String, dynamic>{
      'message': instance.message,
      'objet': instance.objet,
      'offre': instance.offre,
      'etudiant': instance.etudiant,
    };
