import 'package:flutter/material.dart';

import '../../search/widgets/search_app_bar.dart';
import '../Widget/ButtonWidget.dart';
import '../kConst.dart';

class Postuler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 10,
          right: 10,
        ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchAppBar(),
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: Text(
                    'Créer mon offre de stage',
                    textAlign: TextAlign.center,
                    style: loginTitle,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Nom societe',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.post_add_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Nom offre',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    maxLines: 10,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.add_comment,
                          color: Colors.grey,
                        ),
                        hintText: 'Description offre ',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.add_location_alt,
                          color: Colors.grey,
                        ),
                        hintText: 'Lieu stage',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.access_alarm_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Expiration offre',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.access_alarm_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Durée stage',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFF4A4A54),
                  ),
                  child: TextField(
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.key,
                          color: Colors.grey,
                        ),
                        hintText: 'Mots clées',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 40),
                ButtonWidget(
                  text: 'Ajouter une offre',
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}