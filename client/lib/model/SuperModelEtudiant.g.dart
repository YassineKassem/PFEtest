// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelEtudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelEtudiant _$SuperModelEtudiantFromJson(Map<String, dynamic> json) =>
    SuperModelEtudiant(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Etudiant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelEtudiantToJson(SuperModelEtudiant instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
