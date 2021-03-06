// @dart=2.9
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pfe/register.dart';
import 'package:pfe/signin.dart';
import 'package:pfe/welcome_etudiant/Profile/ProfileScreen.dart';
import 'package:pfe/welcome_etudiant/Profile/ViewPDF.dart';
import 'package:pfe/welcome_etudiant/Profile/editPwd.dart';
import 'package:pfe/welcome_societe/widgets/StagiaireDetail.dart';
import 'importerCV.dart';
import 'importerVScreeCv.dart';
import 'loader.dart';
import 'AccueilEtd.dart';
import 'AccueilSoc.dart';
import 'model/CVmodel.dart';
import 'welcome_etudiant/Profile/editCV.dart';
import 'suite_detail_etudiant/Cree_CV/createCVPart1.dart';
import 'suite_detail_societe/formSociete.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'welcome_etudiant/Prédiction/prédire.dart';


void main() async{
  await dotenv.load(fileName: "assets/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  CVmodel userData;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF43B1B7),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFED408))),
      initialRoute: '/',
      routes: {
        '/': (context) => ColorLoader3(),
        //'/': (context) => AccueilEtd(),
        '/createCV': (context) => createCV(),
        '/createCVPart1': (context) => createCVPart1(),
        '/EditPwd': (context) => EditPwd(),
        '/login/société': (context) => MyLogin(),
        '/login/étudiant': (context) => MyLogin(),
        '/register/étudiant': (context) => MyRegister(),
        '/register/société': (context) => MyRegister(),
        '/AccueilEtd': (context) => AccueilEtd(),
        '/AccueilSoc': (context) => AccueilSoc(),
        '/formSociete': (context) => formSociete(),
        '/importerCV': (context) => importerCV(),
        '/importerVScreeCv': (context) => importerVScreeCv(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/prédire': (context) => Prediction()
        
        
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
