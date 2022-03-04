import 'package:flutter/material.dart';
import 'Home.dart';
import 'loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => ColorLoader3(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/second': (context) =>,
      },
      debugShowCheckedModeBanner: false,
    );
  }
}