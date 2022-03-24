import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:pfe/card.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final data = [
    CardPlanetData(
      indice: true,
      title: "SATTAGENY",
      subtitle:
      "SATTAGENY est une application tunisienne développée par deux jeunes étudiants ",
      image: const AssetImage("assets/firstScreens/sattageny.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.black,
      subtitleColor: const Color.fromRGBO(0, 10, 56, 1),
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),
    CardPlanetData(
      indice: true,
      title: "SATTAGENY",
      subtitle: "SATTAGENY permet aux sociétés de créer leurs propres offres de stage afin de trouver les profils souhaités "
          "des étudiants par rapport à l'offre de stage ",
      image: const AssetImage("assets/firstScreens/societe.png"),
      backgroundColor: const Color.fromRGBO(0, 10, 56, 1),
      titleColor: Colors.purple,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-2.json"),
    ),
    CardPlanetData(
      indice: true,
      title: "SATTAGENY",
      subtitle: "SATTAGENY facilite aux etudiants dans le domaine informatique de trouver le meilleur offre de stage "
          "selon leurs besoins.",
      image: const AssetImage("assets/firstScreens/etudiant.png"),
      backgroundColor: const Color.fromRGBO(71, 59, 117, 1),
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-3.json"),
    ),

    CardPlanetData(
      indice: false,
      title: "",
      subtitle: "",
      image: const AssetImage("assets/firstScreens/etudiant.png"),
      backgroundColor: Colors.white,
      titleColor: Colors.yellow,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/animation/bg-1.json"),
    ),


  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
          colors: data.map((e) => e.backgroundColor).toList(),
          itemCount: data.length,
          itemBuilder: (int index, double value) {
            return CardPlanet(data: data[index]) ;
          },
        )
    );
  }
}