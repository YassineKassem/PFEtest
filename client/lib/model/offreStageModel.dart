import 'package:json_annotation/json_annotation.dart';

part 'offreStageModel.g.dart';

@JsonSerializable()
class Stage {
  String? username;
  String? nomOffre;
  String? descriptionOffre;
  String? localisation;
  DateTime? dateExpiration;
  String? duree;


  Stage({this.username, this.nomOffre,this.descriptionOffre,this.localisation,
  this.dateExpiration,this.duree});

    factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson()=> _$StageToJson(this);

}
