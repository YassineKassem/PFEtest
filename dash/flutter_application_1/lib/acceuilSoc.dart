import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_app_barSoc.dart';
import 'package:flutter_application_1/sidebar/menu2.dart';
import 'griddashboard.dart';

class AcceuilSoc  extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const NavigationDrower(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: <Widget>[
          
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
          ),
          SizedBox(
            height: 40,
          ),
          HomeAppBar(),
          GridDashboard()
        ],
      ),
    );
  }
}