import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import '../../NetworkHandler.dart';
import '../../model/Societe.dart';
import '../../model/detailSociete.dart';
import 'editProfilSociete.dart';
import 'editPwdSociete.dart';

class ProfileScreenSoc extends StatefulWidget {
  @override
  _ProfileScreenSoc createState() => _ProfileScreenSoc();
}

class _ProfileScreenSoc extends State<ProfileScreenSoc> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  DetailSociete profileModel = DetailSociete();
  Societe soc = Societe();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    var response = await networkHandler.get("/profileSociete/getData");
    setState(() {
      profileModel = DetailSociete.fromJson(response["data"]);
      circular = false;
    });

    var response2 = await networkHandler.get("/societe");
    setState(() {
      soc = Societe.fromJson(response2["data"]);
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
                          backgroundImage: NetworkHandler()
                              .getImage("${profileModel.societeId}"),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Center(
                          child: Text("${profileModel.username}",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(233, 0, 0, 0)))),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text("${soc.email}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromARGB(233, 220, 191, 72)))),
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
                                  builder: (context) => EditProfileSoc(),
                                ));
                              },
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
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
                                  builder: (context) => EditPwdSoc(),
                                ));
                              },
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
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
}
