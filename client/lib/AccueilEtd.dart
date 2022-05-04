// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/ListPredictOffre.dart';
import 'package:pfe/welcome_etudiant/home_app_bar.dart';
import 'package:pfe/welcome_etudiant/search_card.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';
import 'package:pfe/welcome_etudiant/tag_list.dart';

import 'model/CVmodel.dart';
import 'welcome_etudiant/sidebar/menu2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AccueilEtd extends StatefulWidget {
  
  

  @override
  State<AccueilEtd> createState() =>new _AccueilEtdState();
}

class _AccueilEtdState extends State<AccueilEtd> {
  
  
  Map<String, String> headers = new Map();



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrower(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(),
                SearchCard(),
                Taglist(),
                JobList(),
                /////////////
                //ListPredictOffre(),
                ////////////////
                ],
            ),         
          ],
        ),
      ),
    );
  }
}