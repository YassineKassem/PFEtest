class CVmodel{
  List<String>? nomCompetance;

  List<String>? nomFormation;
  List<String>? etablissementF;
  List<String>? villeF;
  List<DateTime>? datedF;
  List<DateTime>? datefF;
  List<String>? DescriptionF;

  List<String>? nomSociete;
  List<DateTime>? datedS;
  List<DateTime>? datefS;
  List<String>? DescriptionS;

  List<String>? nomLangue;
  List<String>? NiveauLangue;

  List<String>? centreInteret;

  CVmodel({this.nomCompetance,this.nomFormation,
  this.etablissementF,this.villeF,this.datedF,this.datefF,this.DescriptionF,
    this.nomLangue,this.NiveauLangue,this.centreInteret,this.nomSociete,this.DescriptionS,this.datedS,this.datefS});

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> comp =new Map<String,dynamic>();

    comp['nomCompetance']= nomCompetance;

    comp['nomFormation']= nomFormation;
    comp['etablissementF']= etablissementF;
    comp['villeF']= villeF;
    comp['datedF']= datedF;
    comp['datefF']= datefF;
    comp['DescriptionF']= DescriptionF;

    comp['nomSociete']= nomSociete;
    comp['nomSociete']= datedS;
    comp['nomSociete']= datefS;
    comp['nomSociete']= DescriptionS;

    comp['nomLangue']= nomLangue;
    comp['NiveauLangue']= NiveauLangue;

    comp['centreInteret']= centreInteret;
    return comp;
}

}