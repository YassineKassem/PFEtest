// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CVmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVmodel _$CVmodelFromJson(Map<String, dynamic> json) => CVmodel(
      username: json['username'] as String?,
      Competence: json['Competence'] as List<dynamic>?,
      Formation: json['Formation'] as List<dynamic>?,
      Stage: json['Stage'] as List<dynamic>?,
      langue: json['langue'] as List<dynamic>?,
      nom: json['nom'] as String?,
      Prenom: json['Prenom'] as String?,
      email: json['email'] as String?,
      Numerotel: json['Numerotel'] as int?,
      Adresse: json['Adresse'] as String?,
      Codepostale: json['Codepostale'] as String?,
      Ville: json['Ville'] as String?,
      Profile: json['Profile'] as String?,
      Realisation: json['Realisation'] as String?,
      Ci: json['Ci'] as List<dynamic>?,
    );

Map<String, dynamic> _$CVmodelToJson(CVmodel instance) => <String, dynamic>{
      'Competence': instance.Competence,
      'Formation': instance.Formation,
      'Stage': instance.Stage,
      'langue': instance.langue,
      'Ci': instance.Ci,
      'username': instance.username,
      'nom': instance.nom,
      'Prenom': instance.Prenom,
      'email': instance.email,
      'Numerotel': instance.Numerotel,
      'Adresse': instance.Adresse,
      'Codepostale': instance.Codepostale,
      'Ville': instance.Ville,
      'Profile': instance.Profile,
      'Realisation': instance.Realisation,
    };
