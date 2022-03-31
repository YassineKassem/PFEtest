// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Etudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etudiant _$EtudiantFromJson(Map<String, dynamic> json) => Etudiant(
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
      dataFavoris: (json['dataFavoris'] as List<dynamic>?)
          ?.map((e) => Stage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EtudiantToJson(Etudiant instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
      'dataFavoris': instance.dataFavoris,
    };
