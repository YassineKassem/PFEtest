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
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 50),
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
                    'Recherche Rapide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,fontWeight: FontWeight.w500,
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
            SizedBox(height: 70),
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
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    icon: const Icon(Icons.thumb_up_outlined, size: 32,color:Colors.grey),
                    label: const Text('Recommandation',
                        style: TextStyle(color: Colors.grey, fontSize: 20)),
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
