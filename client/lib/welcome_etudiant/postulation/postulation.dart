import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import 'package:pfe/search/widgets/search_input.dart';
import 'package:pfe/search/widgets/search_list.dart';
import 'package:pfe/search/widgets/search_option.dart';

import 'PostulationsList.dart';



class Postulation extends StatefulWidget {
  const Postulation({ Key? key }) : super(key: key);

  @override
  State<Postulation> createState() => _PostulationState();
}


class _PostulationState extends State<Postulation> {
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
                child: PostulationsList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
