// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postulation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

postulation _$postulationFromJson(Map<String, dynamic> json) => postulation(
      etudiantId: json['etudiantId'],
      offreId: json['offreId'],
      message: json['message'] as String?,
      objet: json['objet'] as String?,
    );

Map<String, dynamic> _$postulationToJson(postulation instance) =>
    <String, dynamic>{
      'message': instance.message,
      'objet': instance.objet,
      'offreId': instance.offreId,
      'etudiantId': instance.etudiantId,
    };
