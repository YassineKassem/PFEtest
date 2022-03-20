import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/model/Societe.dart';
import 'model/CVmodel.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final _formKey = GlobalKey<FormState>();
  Etudiant etd = new Etudiant('', '');
  Societe soc = new Societe('', '');

  Future save(String user) async {
    if (user == "etudiant") {
      
      final res = await http.post(
        
          Uri.parse("${dotenv.env['API_URL']}/etudiant/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            
          },
          body: jsonEncode(
              <String, dynamic>{'email': etd.email, 'password': etd.password}));

      
      if (res.statusCode == 200) {

        CVmodel.fromJson(json.decode(res.body));
        Navigator.pushNamed(context, '/AccueilEtd');

      } else if (res.statusCode == 400) {

        return showAlertDialog(context, 'Invalid Email/Password');
      }
    } else if (user == "societe") {

      var res = await http.post(
          Uri.parse("${dotenv.env['API_URL']}/societe/login"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'email': soc.email, 'password': soc.password}));
      print(soc.email);
      print(soc.password);
      print(res.statusCode);

      if (res.statusCode == 200) {

        Navigator.pushNamed(context, '/AccueilSoc');
      } else if (res.statusCode == 400) {

        return showAlertDialog(context, 'Invalid Email/Password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String getUser() {
      String? route = ModalRoute.of(context)?.settings.name;

      String user = '';
      for (int i = 7; i < route!.length; i++) {
        user += route[i];
      }
      return user;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: getUser() == 'etudiant'
                                  ? TextEditingController(text: etd.email)
                                  : TextEditingController(text: soc.email),
                              onChanged: (value) {
                                if (getUser() == 'etudiant')
                                  etd.email = value;
                                else
                                  soc.email = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter something';
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Enter valid email';
                                }
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: getUser() == 'etudiant'
                                  ? TextEditingController(text: etd.password)
                                  : TextEditingController(text: soc.password),
                              onChanged: (value) {
                                if (getUser() == 'etudiant')
                                  etd.password = value;
                                else
                                  soc.password = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter something';
                                }
                                return null;
                              },
                              style: TextStyle(),
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sign in',
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          save(getUser());
                                        } else
                                          print("not ok");
                                      },
                                      icon: Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/register/${getUser()}');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, String text) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
