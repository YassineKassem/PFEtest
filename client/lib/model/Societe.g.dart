// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Societe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Societe _$SocieteFromJson(Map<String, dynamic> json) => Societe(
      username: json['username'] as String?,
      password: json['password'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SocieteToJson(Societe instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
    };
