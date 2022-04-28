import 'package:json_annotation/json_annotation.dart';
part 'recommendation.g.dart';

@JsonSerializable()
class recommendation{
  @JsonKey(name: '_id')
  String? id;
  double? score;
  var postulationId;
  var societeId;




  recommendation({this.id,this.score,this.postulationId,this.societeId});

    factory recommendation.fromJson(Map<String, dynamic> json) => _$recommendationFromJson(json);
    Map<String, dynamic> toJson()=> _$recommendationToJson(this);



}