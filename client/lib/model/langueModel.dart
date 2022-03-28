import 'package:json_annotation/json_annotation.dart';

part 'langueModel.g.dart';

@JsonSerializable()
class LangueModel {
  @JsonKey(name: 'nomLangue')
  String? nomLangue;
  String? NiveauLangue;


  LangueModel({this.nomLangue,this.NiveauLangue});

  factory LangueModel.fromJson(Map<String, dynamic> json) => _$LangueModelFromJson(json);
  Map<String, dynamic> toJson() => _$LangueModelToJson(this);


}