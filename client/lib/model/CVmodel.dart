import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'CVmodel.g.dart';

@JsonSerializable()
class CVmodel {

  List? Competence;
  List? Formation;
  List? Stage;
  List? langue;
  List? Ci;
  
  String? username;
  String? nom;
  String? Prenom;
  String? email ;
  int? Numerotel ;
  String? Adresse ;
  String? Codepostale ;
  String? Ville ;
  String? Profile ;
  String? Realisation ;
 


  CVmodel({this.username,this.Competence,this.Formation,this.Stage,this.langue,
    this.nom,this.Prenom,this.email,this.Numerotel,this.Adresse,this.Codepostale
    ,this.Ville,this.Profile,this.Realisation,this.Ci}) ;


  factory CVmodel.fromJson(Map<String, dynamic> json) => _$CVmodelFromJson(json);
  Map<String, dynamic> toJson()=> _$CVmodelToJson(this);


}


