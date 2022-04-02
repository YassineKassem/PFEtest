import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../NetworkHandler.dart';
import '../model/CVmodel.dart';

class AppBarS extends StatefulWidget {
  const AppBarS({ Key? key }) : super(key: key);
  @override
  State<AppBarS> createState() => AppBarSState();
}

class AppBarSState extends State<AppBarS> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  

  
   @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 215, 168, 86),
      padding: EdgeInsets.only(
        top: 40,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset("assets/icons/menu.svg"),
                ),
              )
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                //backgroundImage:NetworkHandler().getImage("assets/images/avatar.png"),
              )
            ],
          )
        ],
      ),
    );
  }
}

