import 'dart:async';

import 'package:flutter/material.dart';
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
  CVmodel userData;
  AccueilEtd(@required this.userData);

  @override
  State<AccueilEtd> createState() =>new _AccueilEtdState(userData);
}

class _AccueilEtdState extends State<AccueilEtd> {
  
  CVmodel userData;
  Map<String, String> headers = new Map();
  _AccueilEtdState(this.userData);

  
  @override
  void initState() {
    
    headers["x-access-token"] = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJldGRfaWQiOiI2MjM3MTVlMDA5M2UzZTE1MzA3NmUwZGEiLCJlbWFpbCI6IndhcmRpeWFAeWFob28uY29tIiwiaWF0IjoxNjQ3Nzc3MjQ4LCJleHAiOjE2NDc3ODQ0NDh9.lD6COlRFjujjQp6h4zg0mnLqE3DbtLDKH-8-JXLB32s';
    super.initState();

  }
  Future getUserData() async {
    Map<String, dynamic> responseMap;
    final url = '${dotenv.env['API_URL']}/etudiant/welcome';
    await http.get(url, headers: headers)
      .then((response) {
        print(response.body);
        responseMap = json.decode(response.body);
        if(response.statusCode == 200) {
          responseMap = responseMap["userdata"];
        }
        else {
          if(responseMap.containsKey("message"))
            throw(Exception(responseMap["message"]));
        }
      })
      .timeout(Duration(seconds:40),onTimeout: () {
        throw(new TimeoutException("fetch from server timed out"));
      })
      .catchError((err) {
        throw(err);
      });
      
  }


  @override
  Widget build(BuildContext context) {
    getUserData();
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
                ],
            ),         
          ],
        ),
      ),
    );
  }
}