// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'welcome_societe/appBar.dart';
import 'package:pfe/welcome_societe/Dashboard.dart';
import 'welcome_societe/sidebar/menu.dart';

class AccueilSoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const Menu(),
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