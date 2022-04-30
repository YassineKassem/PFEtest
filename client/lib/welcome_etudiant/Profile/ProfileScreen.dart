import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import 'package:pfe/welcome_etudiant/Profile/editProfile.dart';

import '../../NetworkHandler.dart';
import '../../model/CVmodel.dart';
import 'ViewPDF.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  CVmodel profileModel = CVmodel();
  Etudiant etd=Etudiant();
  late File filePdf;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var response = await networkHandler.get("/cv/getData");
     if (!mounted) return;
    setState(() {
      profileModel = CVmodel.fromJson(response["data"]);
      
    });
    
    var response2 = await networkHandler.get("/etudiant/");
     if (!mounted) return;
     setState(() {
      etd = Etudiant.fromJson(response2["data"]);
      circular = false;
    });

   

  }

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: circular
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Stack(
          children: [
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchAppBar(),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage:NetworkHandler().getImage("${profileModel.etudiantId}"),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(child: Text("${profileModel.username}")),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text("${etd.email}")),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ));
                        },
                        color: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "  Modifier profil ",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewPDF(),
                          ));
                        },
                        color: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "   Consulter CV  ",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () { Navigator.pushNamed(context, '/createCV'); },
                        color: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "   Modifier CV   ",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () { Navigator.pushNamed(context, '/EditPwd'); },
                        color: Colors.grey,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "Modifier Mot de passe",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  static Future openFile(String url) async {
    await OpenFile.open(url);
  }
}
