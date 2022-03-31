import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import 'package:pfe/search/widgets/search_input.dart';
import 'package:pfe/search/widgets/search_list.dart';
import 'package:pfe/search/widgets/search_option.dart';

class Favoris extends StatefulWidget {
  const Favoris({ Key? key }) : super(key: key);

  @override
  State<Favoris> createState() => _FavorisState();
}


class _FavorisState extends State<Favoris> {
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
                child: SearchList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
