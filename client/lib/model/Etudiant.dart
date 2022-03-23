import 'package:json_annotation/json_annotation.dart';
part 'Etudiant.g.dart';

@JsonSerializable()
class Etudiant{

  String? email;
  String password;
  String username;
  


  Etudiant(this.username,this.password,[this.email]);

    factory Etudiant.fromJson(Map<String, dynamic> json) => _$EtudiantFromJson(json);
    Map<String, dynamic> toJson()=> _$EtudiantToJson(this);
  

}