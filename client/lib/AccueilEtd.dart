import 'package:flutter/material.dart';

class AccueilEtd extends StatefulWidget {
  const AccueilEtd({ Key? key }) : super(key: key);

  @override
  State<AccueilEtd> createState() => _AccueilEtdState();
}

class _AccueilEtdState extends State<AccueilEtd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text('welcome student'),
    );
  }
}