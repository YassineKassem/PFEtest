import 'package:flutter/material.dart';

class CardPlanetData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;
  ImageProvider societe= AssetImage("assets/firstScreens/entr1.png");
  ImageProvider etudiant= AssetImage("assets/firstScreens/etud1.png");
  final bool indice;

  CardPlanetData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background,
    required this.indice,

  });
}

class CardPlanet extends StatelessWidget {
  const CardPlanet({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CardPlanetData data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (data.background != null) data.background!,
        if(data.indice==true)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 3),
                Flexible(
                  flex: 20,
                  child: Image(image: data.image),
                ),
                const Spacer(flex: 1),
                Text(
                  data.title.toUpperCase(),
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  maxLines: 1,
                ),
                const Spacer(flex: 1),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
                const Spacer(flex: 10),
              ],
            ),
          ),
        if(data.indice==false)
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: <Widget>[
                        Flexible(
                          flex: 20,
                          child: Image(image: data.societe),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Société',style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.bold,),
                              textAlign: TextAlign.center,),
                          ],
                        ),

                      ],
                    ),
                    Stack(
                      children: <Widget>[
                        Flexible(
                          flex: 10,
                          child: Image(image: data.etudiant),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Etudiant',
                          style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      ],
    );
  }
}