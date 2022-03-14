import 'package:flutter/material.dart';
import 'package:pfe/AccueilEtd.dart';
import 'package:pfe/welcome_etudiant/Favoris/favoris.dart';
import 'package:pfe/welcome_etudiant/Profile/ProfileScreen.dart';
import 'package:pfe/welcome_etudiant/postulation/postulation.dart';

class NavigationDrower extends StatefulWidget {
  const NavigationDrower({Key? key}) : super(key: key);

  @override
  State<NavigationDrower> createState() => _NavigationDrowerState();
}

class _NavigationDrowerState extends State<NavigationDrower> {
  bool isSelected = false;
  int nb = -1;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Material(
      color: Color(0xfff1f3f6),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? blocProfilePortrait()
                        : blocProfileLandscape()
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    navigatorTitle(
                        name: "Home",
                        key: 0,
                        onClick: () => selectedItem(context, 0)),
                    navigatorTitle(
                        name: "Profile",
                        key: 1,
                        onClick: () => selectedItem(context, 1)),
                    navigatorTitle(
                        name: "Favoris",
                        key: 2,
                        onClick: () => selectedItem(context, 2)),
                    navigatorTitle(
                        name: "Postulation",
                        key: 3,
                        onClick: () => selectedItem(context, 3)),
                  ],
                ),
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? bloclogoutPortrait()
                    : bloclogoutLandscape()
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget navigatorTitle(
      {required String name, required int key, VoidCallback? onClick}) {
    return InkWell(
      onTap: onClick,
      child: Row(
        children: [
          (nb == key)
              ? Container(
                  width: 5,
                  height: 60,
                  color: Color(0xffffac30),
                )
              : Container(
                  width: 5,
                  height: 60,
                ),
          SizedBox(
            width: 10,
            height: 60,
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: (nb == key) ? FontWeight.w700 : FontWeight.w400),
          )
        ],
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AccueilEtd(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Favoris(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Postulation(),
        ));
        break;
      
    }
  }

  Widget blocProfilePortrait() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
        color: Colors.white,
      ),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfff1f3f6),
                image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.contain)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Carol Johnson",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Text(
                "Seattle Washington",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget blocProfileLandscape() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
        color: Colors.white,
      ),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xfff1f3f6),
                image: DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.contain)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Carol Johnson",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
              ),
              Text(
                "Seattle Washington",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )
            ],
          )
        ]),
      ),
    );
  }

  Widget bloclogoutPortrait() {
    return Container(
      padding: EdgeInsets.only(top: 300, left: 15),
      child: Row(
        children: [
          Icon(
            Icons.power_settings_new,
            size: 30,
          ),
          Text(
            "Logout",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget bloclogoutLandscape() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(
            Icons.power_settings_new,
            size: 30,
          ),
          Text(
            "Logout",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
