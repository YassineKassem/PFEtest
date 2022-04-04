import 'package:json_annotation/json_annotation.dart';

import 'MotCle.dart';

part 'offreStageModel.g.dart';

@JsonSerializable()
class Stage {
  @JsonKey(name: '_id')
  String? id;
  String? username;
  var societeId;
  String? nomOffre;
  String? descriptionOffre;
  String? localisation;
  DateTime? dateExpiration;
  String? duree;
  List<MotCle>? motClee;


  Stage({this.username,this.societeId,this.id, this.nomOffre,this.descriptionOffre,this.localisation,
  this.dateExpiration,this.duree,this.motClee});

    factory Stage.fromJson(Map<String, dynamic> json) => _$StageFromJson(json);
  Map<String, dynamic> toJson()=> _$StageToJson(this);

}
