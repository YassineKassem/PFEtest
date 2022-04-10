import 'package:json_annotation/json_annotation.dart';
part 'postulation.g.dart';

@JsonSerializable()
class postulation{
  @JsonKey(name: '_id')
  String? id;
  String? message;
  String? objet;
  var offreId;
  var etudiantId;



  postulation({this.id,this.etudiantId,this.offreId,this.message,this.objet});

    factory postulation.fromJson(Map<String, dynamic> json) => _$postulationFromJson(json);
    Map<String, dynamic> toJson()=> _$postulationToJson(this);



}