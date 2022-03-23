// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Etudiant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Etudiant _$EtudiantFromJson(Map<String, dynamic> json) => Etudiant(
      json['username'] as String,
      json['password'] as String,
      json['email'] as String?,
    );

Map<String, dynamic> _$EtudiantToJson(Etudiant instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
    };
