// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import 'package:pfe/search/widgets/search_input.dart';
import 'package:pfe/search/widgets/search_list.dart';
import 'package:pfe/search/widgets/search_option.dart';
import 'package:pfe/welcome_societe/widgets/offre_list.dart';



class  ConsulterOffre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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

              SearchAppBar(),
              
              Expanded(
                child: Offre_list(),
              )
            ],
          )
        ],
      ),
    );
  }
}