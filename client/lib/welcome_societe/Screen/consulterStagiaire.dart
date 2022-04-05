import 'package:flutter/material.dart';
import 'package:pfe/welcome_societe/Screen/listStgiaires.dart';
import '../../search/widgets/search_app_bar.dart';
import '../kConst.dart';

class ConsulterStagiaires extends StatefulWidget {
  const ConsulterStagiaires({Key? key}) : super(key: key);

  @override
  State<ConsulterStagiaires> createState() => _ConsulterStagiairesState();
}

class _ConsulterStagiairesState extends State<ConsulterStagiaires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchAppBar(),
                  
                ],
              ),
              Container(
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
