import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pfe/bodyDash.dart';
import 'package:pfe/item_Dash.dart';
import 'package:pfe/welcome_etudiant/home_app_bar.dart';
import 'package:pfe/welcome_etudiant/sidebar/menu2.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';
import 'package:pfe/welcome_etudiant/tag_list.dart';

class AccueilSoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrower(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyDashboard(),
                item_Dash(),
                Taglist(),
                //JobList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}