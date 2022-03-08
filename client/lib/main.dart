import 'package:flutter/material.dart';
import 'package:pfe/register.dart';
import 'package:pfe/signin.dart';
import 'Home.dart';
import 'loader.dart';
import 'AccueilEtd.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => ColorLoader3(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/login': (context) => MyLogin(),
        '/register':(context) => MyRegister(),
        '/AccueilEtd':(context) => AccueilEtd(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
