import 'package:json_annotation/json_annotation.dart';
part 'Societe.g.dart';

@JsonSerializable()
class Societe{

  String? email;
  String? password;
  String? username;



  Societe({this.username,this.password,this.email});

    factory Societe.fromJson(Map<String, dynamic> json) => _$SocieteFromJson(json);
    Map<String, dynamic> toJson()=> _$SocieteToJson(this);



}