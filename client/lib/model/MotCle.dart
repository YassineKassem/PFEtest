import 'package:json_annotation/json_annotation.dart';

part 'MotCle.g.dart';

@JsonSerializable()
class MotCle {
  @JsonKey(name: 'cle')
  String? cle;

  MotCle({this.cle});

  factory MotCle.fromJson(Map<String, dynamic> json) => _$MotCleFromJson(json);
  Map<String, dynamic> toJson() => _$MotCleToJson(this);


}