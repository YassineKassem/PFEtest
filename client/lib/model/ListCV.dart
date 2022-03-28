
class formation{
  List<String>? nomFormation;
  List<String>? etablissementF;
  List<String>? villeF;
  List<DateTime>? datedF;
  List<DateTime>? datefF;
  List<String>? DescriptionF;

  formation({this.nomFormation,this.etablissementF,this.villeF,this.datedF,this.datefF,this.DescriptionF});

}

class stage{
  List<String>? nomSociete;
  List<DateTime>? datedS;
  List<DateTime>? datefS;
  List<String>? DescriptionS;

  stage({this.nomSociete,this.DescriptionS,this.datedS,this.datefS});


}


class langues{
  List<String>? nomLangue;
  List<String>? NiveauLangue;

  langues({this.nomLangue,this.NiveauLangue,});


}


class competance{
  List<String>? nomCompetance;

  competance({this.nomCompetance});


}

class Interet{
  List<String>? centreInteret;

  Interet({this.centreInteret});

  
}


