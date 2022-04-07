class offre {
  String company;
  String logoUrl;
  bool isMark;
  String title;
  String location;
  String time;
  List<String> req;
  offre(this.company, this.logoUrl, this.isMark, this.title, this.location,
      this.req,this.time);
  static List<offre> generateOffres() {
    return [
      offre("company", "assets/images/avatar.png", false, "title", "location",
          ["azertyuiop"],"3 mois"),
      offre("company", "assets/images/avatar.png", false, "title", "location",
          ["azertyuiop"],"3 mois"),
      offre("company", "assets/images/avatar.png", false, "title", "location",
          ["azertyuiop"],"3 mois"),
      offre("company", "assets/images/avatar.png", false, "title", "location",
          ["azertyuiop"],"3 mois"),
      offre("company", "assets/images/avatar.png", false, "title", "location",
          ["azertyuiop"],"3 mois"),
    ];
  }
}