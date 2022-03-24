import 'package:flutter/material.dart';
import 'package:flutter_application_1/acceuilSoc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'griddashboard.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Color(0xFF43B1B7),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFFED408))),
      initialRoute: '/',
      routes: {
        '/': (context) => AcceuilSoc(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
