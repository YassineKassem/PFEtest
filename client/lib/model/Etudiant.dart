import 'package:json_annotation/json_annotation.dart';
import 'offreStageModel.dart';
part 'Etudiant.g.dart';


@JsonSerializable()
class Etudiant{
  @JsonKey(name: '_id')
  String? id;
  String? email;
  String? password;
  String? username;
  List<Stage>? dataFavoris;


  Etudiant({this.id,this.username,this.password,this.email,this.dataFavoris});

    factory Etudiant.fromJson(Map<String, dynamic> json) => _$EtudiantFromJson(json);
    Map<String, dynamic> toJson()=> _$EtudiantToJson(this);
  

}