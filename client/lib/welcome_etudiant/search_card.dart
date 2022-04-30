import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/search/search.dart';

import 'ListPredictOffre.dart';

class SearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              image: AssetImage('assets/images/register.png'),
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
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 30),
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
                SizedBox(width: 30),
                Text(
                  'search',
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
    );
  }
}
