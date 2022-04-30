import 'package:json_annotation/json_annotation.dart';
part 'recommendationOffre.g.dart';

@JsonSerializable()
class recommendationOffre{
  @JsonKey(name: '_id')
  String? id;
  double? score;
  var offreId;
  var etudiantId;




  recommendationOffre({this.id,this.score,this.offreId,this.etudiantId});

    factory recommendationOffre.fromJson(Map<String, dynamic> json) => _$recommendationOffreFromJson(json);
    Map<String, dynamic> toJson()=> _$recommendationOffreToJson(this);



}