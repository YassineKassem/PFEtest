import 'package:json_annotation/json_annotation.dart';

import 'postulation.dart';

part 'SuperModelPostulation.g.dart';

@JsonSerializable()
class SuperModelPostulation {
  List<postulation>? data;

  SuperModelPostulation({this.data});
  
  factory SuperModelPostulation.fromJson(Map<String, dynamic> json) =>
      _$SuperModelPostulationFromJson(json);
  Map<String, dynamic> toJson() => _$SuperModelPostulationToJson(this);
}