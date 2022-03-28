import 'package:json_annotation/json_annotation.dart';

part 'competanceModel.g.dart';

@JsonSerializable()
class CompetanceModel {
  @JsonKey(name: 'nomCompetence')
  String? nomCompetence;

  CompetanceModel({this.nomCompetence});

  factory CompetanceModel.fromJson(Map<String, dynamic> json) => _$CompetanceModelFromJson(json);
  Map<String, dynamic> toJson() => _$CompetanceModelToJson(this);


}