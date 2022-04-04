// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailSociete.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailSociete _$DetailSocieteFromJson(Map<String, dynamic> json) =>
    DetailSociete(
      username: json['username'] as String?,
      societeId: json['societeId'],
      nom: json['nom'] as String?,
      SecteurActivite: json['SecteurActivite'] as String?,
      CodeFiscal: json['CodeFiscal'] as String?,
      Email: json['Email'] as String?,
      EmailR: json['EmailR'] as String?,
      CodePostal: json['CodePostal'] as String?,
      tel: json['tel'] as int?,
    );

Map<String, dynamic> _$DetailSocieteToJson(DetailSociete instance) =>
    <String, dynamic>{
      'username': instance.username,
      'societeId': instance.societeId,
      'nom': instance.nom,
      'SecteurActivite': instance.SecteurActivite,
      'CodeFiscal': instance.CodeFiscal,
      'Email': instance.Email,
      'EmailR': instance.EmailR,
      'CodePostal': instance.CodePostal,
      'tel': instance.tel,
    };
