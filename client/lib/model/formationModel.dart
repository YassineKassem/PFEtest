import 'package:json_annotation/json_annotation.dart';

part 'formationModel.g.dart';

@JsonSerializable()
class FormationModel {
  @JsonKey(name: 'nomFormation')
  String? nomFormation;
  String? etablissementF;
  String? villeF;
  String? datedF;
  String? datefF;
  String? DescriptionF;


  FormationModel({this.nomFormation,this.etablissementF,this.villeF,
  this.datedF,this.datefF,this.DescriptionF});

  factory FormationModel.fromJson(Map<String, dynamic> json) => _$FormationModelFromJson(json);
  Map<String, dynamic> toJson() => _$FormationModelToJson(this);


}