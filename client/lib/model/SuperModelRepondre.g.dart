// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelRepondre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelRepondre _$SuperModelRepondreFromJson(Map<String, dynamic> json) =>
    SuperModelRepondre(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => repondreEtudiant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelRepondreToJson(SuperModelRepondre instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
