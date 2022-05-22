// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SuperModelNotif.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperModelNotif _$SuperModelNotifFromJson(Map<String, dynamic> json) =>
    SuperModelNotif(
      data1: (json['data1'] as List<dynamic>?)
          ?.map((e) => repondreEtudiant.fromJson(e as Map<String, dynamic>))
          .toList(),
      data2: (json['data2'] as List<dynamic>?)
          ?.map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperModelNotifToJson(SuperModelNotif instance) =>
    <String, dynamic>{
      'data1': instance.data1,
      'data2': instance.data2,
    };
