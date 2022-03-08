import 'package:flutter/material.dart';

class AccueilSoc extends StatefulWidget {
  const AccueilSoc({ Key? key }) : super(key: key);

  @override
  State<AccueilSoc> createState() => _AccueilSocState();
}

class _AccueilSocState extends State<AccueilSoc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text('welcome societe'),
    );
  }
}