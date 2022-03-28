import 'package:json_annotation/json_annotation.dart';
import 'competanceModel.dart';
import 'centreInteretModel.dart';
import 'formationModel.dart';
import 'stageModel.dart';
import 'langueModel.dart';
part 'CVmodel.g.dart';

@JsonSerializable()
class CVmodel {

  List<CompetanceModel>? Competence;
  List<FormationModel>? Formations;
  List<StageModel>? Stage;
  List<LangueModel>? langue;
  List<CentreInteretModel>? Ci;
  
  String? username;
  String? nom;
  String? Prenom;
  String? email ;
  int? Numerotel ;
  String? Adresse ;
  String? Codepostale ;
  String? Ville ;
  String? Profil ;
  String? Realisation ;

  CVmodel({this.username,this.Competence,this.Formations,this.Stage,this.langue,
    this.nom,this.Prenom,this.email,this.Numerotel,this.Adresse,this.Codepostale
    ,this.Ville,this.Profil,this.Realisation,this.Ci}) ;

  factory CVmodel.fromJson(Map<String, dynamic> json) => _$CVmodelFromJson(json);
  Map<String, dynamic> toJson()=> _$CVmodelToJson(this);


}


