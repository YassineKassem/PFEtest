import 'package:json_annotation/json_annotation.dart';
part 'repondreEtudiant.g.dart';

@JsonSerializable()
class repondreEtudiant{
  @JsonKey(name: '_id')
  String? id;
  String? message;
  String? objet;
  DateTime? date;
  var postulationId;
  var societeId;




  repondreEtudiant({this.id,this.date,this.message,this.objet,this.postulationId,this.societeId,});

    factory repondreEtudiant.fromJson(Map<String, dynamic> json) => _$repondreEtudiantFromJson(json);
    Map<String, dynamic> toJson()=> _$repondreEtudiantToJson(this);



}