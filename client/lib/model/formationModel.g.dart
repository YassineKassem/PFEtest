// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formationModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormationModel _$FormationModelFromJson(Map<String, dynamic> json) =>
    FormationModel(
      nomFormation: json['nomFormation'] as String?,
      etablissementF: json['etablissementF'] as String?,
      villeF: json['villeF'] as String?,
      datedF: json['datedF'] as String?,
      datefF: json['datefF'] as String?,
      DescriptionF: json['DescriptionF'] as String?,
    );

Map<String, dynamic> _$FormationModelToJson(FormationModel instance) =>
    <String, dynamic>{
      'nomFormation': instance.nomFormation,
      'etablissementF': instance.etablissementF,
      'villeF': instance.villeF,
      'datedF': instance.datedF,
      'datefF': instance.datefF,
      'DescriptionF': instance.DescriptionF,
    };
