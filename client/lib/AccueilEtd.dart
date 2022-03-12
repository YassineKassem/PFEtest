import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/home_app_bar.dart';
import 'package:pfe/welcome_etudiant/search_card.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';
import 'package:pfe/welcome_etudiant/tag_list.dart';
import 'welcome_etudiant/sidebar/menu2.dart';

class AccueilEtd extends StatelessWidget {
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
                HomeAppBar(),
                SearchCard(),
                Taglist(),
                JobList(),
                ],
            ),         
          ],
        ),
      ),
    );
  }
}
