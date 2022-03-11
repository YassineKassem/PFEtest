import 'package:flutter/material.dart';
import 'package:pfe/home_app_bar.dart';
import 'package:pfe/search_card.dart';
import 'package:pfe/stage_list.dart';
import 'package:pfe/tag_list.dart';

class AccueilEtd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(),
              SearchCard(),
              Taglist(),
              JobList(),
              ],
          )
        ],
      ),
    );
  }
}
