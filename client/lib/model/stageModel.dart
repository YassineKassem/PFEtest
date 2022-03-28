import 'package:json_annotation/json_annotation.dart';

part 'stageModel.g.dart';

@JsonSerializable()
class StageModel {
  @JsonKey(name: 'nomSociete')
  String? nomSociete;
  String? datedS;
  String? datefS;
  String? DescriptionS;


  StageModel({this.nomSociete,
  this.datedS,this.datefS,this.DescriptionS});

  factory StageModel.fromJson(Map<String, dynamic> json) => _$StageModelFromJson(json);
  Map<String, dynamic> toJson() => _$StageModelToJson(this);


}