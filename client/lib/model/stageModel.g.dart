// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stageModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StageModel _$StageModelFromJson(Map<String, dynamic> json) => StageModel(
      nomSociete: json['nomSociete'] as String?,
      datedS: json['datedS'] as String?,
      datefS: json['datefS'] as String?,
      DescriptionS: json['DescriptionS'] as String?,
    );

Map<String, dynamic> _$StageModelToJson(StageModel instance) =>
    <String, dynamic>{
      'nomSociete': instance.nomSociete,
      'datedS': instance.datedS,
      'datefS': instance.datefS,
      'DescriptionS': instance.DescriptionS,
    };
