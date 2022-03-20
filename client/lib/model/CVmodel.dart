import 'package:pfe/model/Etudiant.dart';

class CVmodel extends Etudiant{

  List<competanceList>? competances;
  List<InteretList>? Interets;
  List<formationList>? formations;
  List<stageList>? stages;
  List<langueList>? langues;

  String? Nom;
  String? Prenom;
  String? Adressemail ;
  String? Numerotel ;
  String? Adresse ;
  String? Codepostale ;
  String? Ville ;
  String? Profile ;
  String? Realisation ;
  String? token;


  CVmodel({this.Interets,this.competances,this.formations,this.stages,this.langues,
    this.Nom,this.Prenom,this.Adressemail,this.Numerotel,this.Adresse,this.Codepostale
    ,this.Ville,this.Profile,this.Realisation,this.token}) : super('', '');



  void addData (Map<String, dynamic> responseMap) {
        this.Nom= responseMap['Nom'];
        this.Prenom= responseMap['Prenom'];
        this.Adressemail= responseMap['Adressemail'];
        this.Numerotel=responseMap['Numerotel'];
        this.Adresse= responseMap['Adresse'];
        this.Codepostale=responseMap['Codepostale'];
        this.Ville= responseMap['Ville'];
        this.token= responseMap['token'];
  }


  factory CVmodel.fromJson(Map<String, dynamic> json) => CVmodel(
      
        Nom: json['Nom'],
        Prenom: json['Prenom'],
        Adressemail: json['Adressemail'],
        Numerotel:json['Numerotel'],
        Adresse: json['Adresse'],
        Codepostale: json['Codepostale'],
        Ville: json['Ville'],
        token: json['token']

    );

  Map toJson() => {
        "Nom": Nom,
        "Prenom": Prenom,
        "Adressemail": Adressemail,
        "Numerotel": Numerotel,
        "Adresse": Adresse,
        "Codepostale": Codepostale,
        "Ville": Ville,
        "token": token,

        "formations": List<dynamic>.from(formations!.map((x) => x.toJson())),
        "Interets": List<dynamic>.from(Interets!.map((x) => x.toJson())),
        "competances": List<dynamic>.from(competances!.map((x) => x.toJson())),
        "stages": List<dynamic>.from(stages!.map((x) => x.toJson())),
        "langues": List<dynamic>.from(langues!.map((x) => x.toJson())),

    }; 


}


class formation{
  List<String>? nomFormation;
  List<String>? etablissementF;
  List<String>? villeF;
  List<DateTime>? datedF;
  List<DateTime>? datefF;
  List<String>? DescriptionF;

  formation({this.nomFormation,this.etablissementF,this.villeF,this.datedF,this.datefF,this.DescriptionF});

  factory formation.fromJson(Map<String, dynamic> json) => formation(
        nomFormation: json["nomFormation"],
        etablissementF: json["etablissementF"],
        villeF: json["villeF"],
        datedF: json["datedF"],
        datefF: json["datefF"],
        DescriptionF: json["DescriptionF"],

    );

    Map<String, dynamic> toJson() => {
        "nomFormation": nomFormation,
        "etablissementF": etablissementF,
        "villeF": villeF,
        "datedF": datedF,
        "datefF": datefF,
        "DescriptionF": DescriptionF,
    };
}

class formationList{
  String nomFormation;
  String etablissementF;
  String villeF;
  String datedF;
  String datefF;
  String DescriptionF;

  formationList(this.nomFormation,this.etablissementF,this.villeF,this.datedF,this.datefF,this.DescriptionF);

    Map toJson() => {
        'nomFormation': nomFormation,
        'etablissementF': etablissementF,
        'villeF': villeF,
       'datedF': datedF,
        'datefF': datefF,
        'DescriptionF': DescriptionF,
    };
}

class stage{
  List<String>? nomSociete;
  List<DateTime>? datedS;
  List<DateTime>? datefS;
  List<String>? DescriptionS;

  stage({this.nomSociete,this.DescriptionS,this.datedS,this.datefS});

  factory stage.fromJson(Map<String, dynamic> json) => stage(
        nomSociete: json["nomSociete"],
        datedS: json["datedS"],
        datefS: json["datefS"],
        DescriptionS: json["DescriptionS"],
    );

    Map<String, dynamic> toJson() => {
        "nomSociete": nomSociete,
        "datedS": datedS,
        "datefS": datefS,
        "DescriptionS": DescriptionS,
    };
}

class stageList{
  String nomSociete;
  String datedS;
  String datefS;
  String DescriptionS;

  stageList(this.nomSociete,this.datedS,this.datefS,this.DescriptionS,);

    Map toJson() => {
        "nomSociete": nomSociete,
        "datedS": datedS,
        "datefS": datefS,
        "DescriptionS": DescriptionS,
    };
}



class langue{
  List<String>? nomLangue;
  List<String>? NiveauLangue;

  langue({this.nomLangue,this.NiveauLangue,});

  factory langue.fromJson(Map<String, dynamic> json) => langue(
        nomLangue: json["nomLangue"],
        NiveauLangue: json["NiveauLangue"],

    );

    Map<String, dynamic> toJson() => {
        "nomLangue": nomLangue,
        "NiveauLangue": NiveauLangue,
    };
}

class langueList{
  String nomLangue;
  String NiveauLangue;

  langueList(this.nomLangue,this.NiveauLangue);
 
    Map toJson() => {
        "nomLangue": nomLangue,
        "NiveauLangue": NiveauLangue,
    };
}

class competance{
  List<String>? nomCompetance;

  competance({this.nomCompetance});

  factory competance.fromJson(Map<String, dynamic> json) => competance(
        nomCompetance: json["nomCompetance"],
    
    );

    Map<String, dynamic> toJson() => {
        "nomCompetance": nomCompetance,
    };
}
class competanceList{
  String nomCompetance;

  competanceList(this.nomCompetance);

    Map toJson() => {
        "nomCompetance": nomCompetance,
    };
}

class Interet{
  List<String>? centreInteret;

  Interet({this.centreInteret});

  factory Interet.fromJson(Map<String, dynamic> json) => Interet(
        centreInteret: json["centreInteret"],
    
    );

    Map<String, dynamic> toJson() => {
        "centreInteret": centreInteret,
    };
}

class InteretList{
  String centreInteret;

  InteretList(this.centreInteret);

    Map toJson() => {
        "centreInteret": centreInteret,
    };
}
