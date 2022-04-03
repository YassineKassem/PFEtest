import 'package:json_annotation/json_annotation.dart';
part 'postulation.g.dart';

@JsonSerializable()
class postulation{

  String? message;
  String? objet;
  var offre;
  var etudiant;



  postulation({this.etudiant,this.offre,this.message,this.objet});

    factory postulation.fromJson(Map<String, dynamic> json) => _$postulationFromJson(json);
    Map<String, dynamic> toJson()=> _$postulationToJson(this);



}