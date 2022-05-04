// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/search/search.dart';

import 'ListPredictOffre.dart';

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 40,
        ),
        height: 300,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage('assets/images/actualite.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recherche Rapide ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Trouvez votre stage rapidement \n On y va',
              style: TextStyle(
                  height: 1.8,
                  color: Color.fromARGB(255, 0, 1, 3),
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(children: [
                  Image.asset('assets/icons/search.png', width: 40),
                  SizedBox(width: 20),
                  Text(
                    'Rechercher',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 40,
        ),
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                image: AssetImage('assets/images/actualite.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prédire une offre de stage',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              child: Container(
                
                child: Row(children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25),
                      primary: Color.fromRGBO(100, 80, 85, 97),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    icon: const Icon(Icons.border_color_outlined, size: 32),
                    label: const Text('Prédire',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/prédire');
                    },
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
