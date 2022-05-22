import 'package:json_annotation/json_annotation.dart';

import 'repondreEtudiant.dart';
import 'offreStageModel.dart';
part 'SuperModelNotif.g.dart';

@JsonSerializable()
class SuperModelNotif {
  List<repondreEtudiant>? data1;
  List<Stage>? data2;

  SuperModelNotif({this.data1,this.data2});
  
  factory SuperModelNotif.fromJson(Map<String, dynamic> json) =>
      _$SuperModelNotifFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelNotifToJson(this);
}