import 'package:json_annotation/json_annotation.dart';
import 'recommendationOffre.dart';


part 'SuperModelRecommandationOffre.g.dart';

@JsonSerializable()
class SuperModelRecommandationOffre {
  List<recommendationOffre>? data;

  SuperModelRecommandationOffre({this.data});
  
  factory SuperModelRecommandationOffre.fromJson(Map<String, dynamic> json) =>
      _$SuperModelRecommandationOffreFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelRecommandationOffreToJson(this);
}