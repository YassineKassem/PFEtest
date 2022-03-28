import 'package:json_annotation/json_annotation.dart';

import 'offreStageModel.dart';

part 'SuperModelOffreStage.g.dart';

@JsonSerializable()
class SuperModelOffreStage {
  List<Stage>? data;

  SuperModelOffreStage({this.data});
  
  factory SuperModelOffreStage.fromJson(Map<String, dynamic> json) =>
      _$SuperModelOffreStageFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelOffreStageToJson(this);
}