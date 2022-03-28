import 'package:json_annotation/json_annotation.dart';

part 'centreInteretModel.g.dart';

@JsonSerializable()
class CentreInteretModel {
  @JsonKey(name: 'nomCi')
  String? nomCi;

  CentreInteretModel({this.nomCi});

  factory CentreInteretModel.fromJson(Map<String, dynamic> json) => _$CentreInteretModelFromJson(json);
  Map<String, dynamic> toJson() => _$CentreInteretModelToJson(this);


}