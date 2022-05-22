import 'package:json_annotation/json_annotation.dart';

import 'repondreEtudiant.dart';

part 'SuperModelRepondre.g.dart';

@JsonSerializable()
class SuperModelRepondre {
  List<repondreEtudiant>? data;

  SuperModelRepondre({this.data});
  
  factory SuperModelRepondre.fromJson(Map<String, dynamic> json) =>
      _$SuperModelRepondreFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelRepondreToJson(this);
}