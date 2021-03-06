// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../NetworkHandler.dart';
import '../model/CVmodel.dart';
import 'Notification/notification.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({ Key? key }) : super(key: key);
  @override
  State<HomeAppBar> createState() => HomeAppBarState();
}

class HomeAppBarState extends State<HomeAppBar> {
  
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  CVmodel profileModel = CVmodel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/cv/getData");
    setState(() {
      profileModel = CVmodel.fromJson(response["data"]);
      circular = false;
    });
  }

   @override
  Widget build(BuildContext context) {
    return circular
          // ignore: prefer_const_constructors
          ? Center(child: CircularProgressIndicator())
          :Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
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
              Container(
                margin: EdgeInsets.only(top: 30, right: 10),
                transform: Matrix4.rotationZ(100),
                child: Stack(
                  children: [
                      GestureDetector(
                        onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => notification(),
                           ));
                        },
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
              CircleAvatar(
                radius: 20,
                backgroundImage:
                NetworkHandler().getImage("${profileModel.etudiantId}")
                ),
              
            ],
          )
        ],
      ),
    );
  }
}

