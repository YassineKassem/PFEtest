// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CVmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CVmodel _$CVmodelFromJson(Map<String, dynamic> json) => CVmodel(
      username: json['username'] as String?,
      Competence: (json['Competence'] as List<dynamic>?)
          ?.map((e) => CompetanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Formations: (json['Formations'] as List<dynamic>?)
          ?.map((e) => FormationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      Stage: (json['Stage'] as List<dynamic>?)
          ?.map((e) => StageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      langue: (json['langue'] as List<dynamic>?)
          ?.map((e) => LangueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      nom: json['nom'] as String?,
      Prenom: json['Prenom'] as String?,
      email: json['email'] as String?,
      Numerotel: json['Numerotel'] as int?,
      Adresse: json['Adresse'] as String?,
      Codepostale: json['Codepostale'] as String?,
      Ville: json['Ville'] as String?,
      Profil: json['Profil'] as String?,
      Realisation: json['Realisation'] as String?,
      Ci: (json['Ci'] as List<dynamic>?)
          ?.map((e) => CentreInteretModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CVmodelToJson(CVmodel instance) => <String, dynamic>{
      'Competence': instance.Competence,
      'Formations': instance.Formations,
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
      'Profil': instance.Profil,
      'Realisation': instance.Realisation,
    };
