import 'package:json_annotation/json_annotation.dart';
import 'Etudiant.dart';


part 'SuperModelEtudiant.g.dart';

@JsonSerializable()
class SuperModelEtudiant {
  List<Etudiant>? data;

  SuperModelEtudiant({this.data});
  
  factory SuperModelEtudiant.fromJson(Map<String, dynamic> json) =>
      _$SuperModelEtudiantFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelEtudiantToJson(this);
}