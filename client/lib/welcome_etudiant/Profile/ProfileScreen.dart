import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import 'package:pfe/welcome_etudiant/Profile/editProfile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
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
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(child: Text("mohamed")),
                SizedBox(
                  height: 10,
                ),
                Center(child: Text("mohamed@gmail.com")),
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
                        onPressed: () {},
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
                        onPressed: () {},
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
