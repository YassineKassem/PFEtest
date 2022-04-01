import 'package:flutter/material.dart';
import 'welcome_societe/appBar.dart';
//import 'package:pfe/welcome_etudiant/sidebar/menu2.dart';
import 'package:pfe/welcome_societe/Dashboard.dart';

class AccueilSoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //drawer: const NavigationDrower(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarS(),
                Dashboard(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}