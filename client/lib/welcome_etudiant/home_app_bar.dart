import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      onTap: (){Scaffold.of(context).openDrawer();},
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
                    Icon(
                      Icons.notification_add_outlined,
                      size: 30,
                      color: Colors.grey,
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
              SizedBox(width: 20,),
              ClipOval(
                child: Image.asset('assets/images/avatar.png',width:40,),
              )

            ],
          )
        ],

      ),
    );
  }
}
