import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfe/loader.dart';
import 'package:pfe/model/Societe.dart';
import '../../AccueilSoc.dart';
import '../../NetworkHandler.dart';
import '../../model/detailSociete.dart';
import '../Profil/profilScreenSociete.dart';
import '../Screen/CreeOffre.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final storage = FlutterSecureStorage();
  bool isSelected = false;
  int nb = -1;
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  DetailSociete profileModel = DetailSociete();
  Societe soc=Societe();
  @override
  void initState() {
    super.initState();

    fetchData();
  }
  void fetchData() async {
    var response = await networkHandler.get("/profileSociete/getData");
     if (!mounted) return;
    setState(() {
      profileModel = DetailSociete.fromJson(response["data"]);
      circular = false;
    });
    
    var response2 = await networkHandler.get("/societe");
     if (!mounted) return;
     setState(() {
      soc = Societe.fromJson(response2["data"]);
    }); 
  }
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
                        name: "Créer mon offre de stage",
                        key: 2,
                        onClick: () => selectedItem(context, 2)),
                    navigatorTitle(
                        name: "Consulter mes offres",
                        key: 1,
                        onClick: () => selectedItem(context, 1)),
                    navigatorTitle(
                        name: "Consulter les stagiaires\n pour mes stages",
                        key: 1,
                        onClick: () => selectedItem(context, 1)),
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
          builder: (context) => AccueilSoc(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProfileScreenSoc(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreeOffre(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreeOffre(),
        ));
        break;
      
    }
  }

  Widget blocProfilePortrait() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 50,
            height: 50,
            child: circular
          ? Center(child: CircularProgressIndicator())
          :CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkHandler().getImage("${profileModel.societeId}"),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profileModel.username}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${soc.email}",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget blocProfileLandscape() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width * 0.38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: 50,
            height: 50,
            child:circular
          ? Center(child: CircularProgressIndicator())
          :CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkHandler().getImage("${profileModel.username}"),
                  ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${profileModel.username}",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                Text(
                  "${soc.email}",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Widget bloclogoutPortrait() {
    return Container(
      padding: EdgeInsets.only(top: 230, left: 15),
      child: GestureDetector(
        onTap: logout,
        child: Row(
          children: [
            Icon(
              Icons.power_settings_new,
              size: 30,
            ),
            Text(
              "Logout",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  Widget bloclogoutLandscape() {
    return Container(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: logout,
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
      ),
    );
  }
  void logout() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => ColorLoader3()),
        (route) => false);
  }

}
