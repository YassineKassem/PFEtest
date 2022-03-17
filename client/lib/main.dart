// @dart=2.9
import 'package:flutter/material.dart';
import 'package:pfe/register.dart';
import 'package:pfe/signin.dart';
import 'Home.dart';
import 'loader.dart';
import 'AccueilEtd.dart';
import 'AccueilSoc.dart';
import 'suite_detail_etudiant/Cree_CV/createCV.dart';
import 'suite_detail_societe/formSociete.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF43B1B7),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFED408))),
      initialRoute: '/',
      routes: {
        // '/': (context) => ColorLoader3(),
        //'/': (context) => AccueilEtd(),
        '/': (context) => createCV(),

        '/login/societe': (context) => MyLogin(),
        '/login/etudiant': (context) => MyLogin(),
        '/register/etudiant': (context) => MyRegister(),
        '/register/societe': (context) => MyRegister(),
        '/AccueilEtd': (context) => AccueilEtd(),
        '/AccueilSoc': (context) => AccueilSoc(),

        '/formSociete': (context) => formSociete(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
