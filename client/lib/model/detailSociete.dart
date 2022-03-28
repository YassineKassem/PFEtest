import 'package:json_annotation/json_annotation.dart';
part 'detailSociete.g.dart';

@JsonSerializable()
class DetailSociete {

  String? username;
  String? nom;
  String? SecteurActivite;
  String? CodeFiscal;
  String? Email;
  String? EmailR;
  String? CodePostal;
  int? tel;

  DetailSociete({this.username,this.nom,this.SecteurActivite,
  this.CodeFiscal,this.Email,this.EmailR,this.CodePostal,this.tel}) ;

  factory DetailSociete.fromJson(Map<String, dynamic> json) => _$DetailSocieteFromJson(json);
  Map<String, dynamic> toJson()=> _$DetailSocieteToJson(this);


}


