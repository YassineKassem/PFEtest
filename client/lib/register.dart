// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/model/Societe.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'NetworkHandler.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  NetworkHandler networkHandler = NetworkHandler();
  final _formKey = GlobalKey<FormState>();
  Etudiant etd = Etudiant(username: '', password: '', email: '');
  Societe soc = Societe(username: '', password: '', email: '');
  String errorText = '';
  bool validate=false;
  bool validate2=true;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    String getUser() {
      String? route = ModalRoute.of(context)?.settings.name;
      print(route);
      String user = '';
      for (int i = 10; i < route!.length; i++) {
        user += route[i];
      }

      return user;
    }

    print(getUser());

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 35, top: 30),
                child: Text(
                  'Créer\nvotre compte',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
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
                              controller: getUser() == 'étudiant'
                                  ? TextEditingController(text: etd.username)
                                  : TextEditingController(text: soc.username),
                                
                              onChanged: (value) {
                                if (getUser() == 'étudiant')
                                  etd.username = value;
                                else
                                  soc.username = value;
                              },
                              
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  errorText: validate || validate2 ? null : errorText,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Nom d'utilisateur",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: getUser() == 'étudiant'
                                  ? TextEditingController(text: etd.email)
                                  : TextEditingController(text: soc.email),
                              onChanged: (value) {
                                print(value);
                                if (getUser() == 'étudiant')
                                  etd.email = value;
                                else
                                  soc.email = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Champ Email ne doit pas être vide';
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return null;
                                } else {
                                  return 'Entrer un email valide ';
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "E-mail",
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: getUser() == 'étudiant'
                                  ? TextEditingController(text: etd.password)
                                  : TextEditingController(text: soc.password),
                              onChanged: (value) {
                                print(value);
                                if (getUser() == 'étudiant')
                                  etd.password = value;
                                else
                                  soc.password = value;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Vueillez saisir votre mot de passe';
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Mot de passe",
                                  hintStyle: TextStyle(color: Colors.white),
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
                                  "S’inscrire",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                circular
                                    ? CircularProgressIndicator()
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Color(0xff4c505b),
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () async {
                                              setState(() {
                                                circular = true;
                                              });

                                              if (getUser() == 'étudiant') {
                                                await checkUserEtd();
                                                
                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    validate) {
                                                  Map<String, dynamic> data = {
                                                    "username": etd.username,
                                                    "password": etd.password,
                                                    "email": etd.email
                                                  };

                                                  print(data);
                                                  var response =
                                                      await networkHandler.post(
                                                          "/etudiant/register",
                                                          data);
                                                  Map<String, dynamic> output =
                                                      json.decode(
                                                          response.body);
                                                  print(output["token"]);
                                                  await storage.write(
                                                      key: "token",
                                                      value: output["token"]);
                                                  setState(() {
                                                    circular = false;
                                                  });
                                                  Navigator.pushNamed(context,
                                                      '/importerVScreeCv');
                                                } else {
                                                  print("not ok");
                                                  setState(() {
                                                    circular = false;
                                                  });
                                                }
                                              } else {
                                                
                                                await checkUserSoc();
                                                      
                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    validate) {
                                                  Map<String, dynamic> data = {
                                                    "username": soc.username,
                                                    "password": soc.password,
                                                    "email": soc.email
                                                  };
                                                  print(data);
                                                  var response =
                                                      await networkHandler.post(
                                                          "/societe/register",
                                                          data);
                                                  Map<String, dynamic> output =
                                                      json.decode(
                                                          response.body);
                                                  print(output["token"]);
                                                  await storage.write(
                                                      key: "token",
                                                      value: output["token"]);
                                                  setState(() {
                                                    circular = false;
                                                  });
                                                  Navigator.pushNamed(
                                                      context, '/formSociete');
                                                } else {
                                                  print("not ok");
                                                  setState(() {
                                                    circular = false;
                                                  });
                                                }
                                              }
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
                                        context, '/login/${getUser()}');
                                  },
                                  child: Text(
                                    'Se connecter',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.white,
                                        fontSize: 18),
                                  ),
                                  style: ButtonStyle(),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkUserEtd() async {
    if (etd.username?.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        validate2 =false;
        errorText = "Champ Username ne doit pas etre vide";
      });
    } else {
      var response =
          await networkHandler.get("/etudiant/checkUsername/${etd.username}");
      if (response['Status']) {
        setState(() {
          circular = false;
          validate = false;
          validate2 =false;
          errorText = "Username deja existe";
        });
      } else {
        setState(() {
          circular = false;
          validate = true;
        });
      }
    }
  }

  checkUserSoc() async {
    if (soc.username?.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        validate2 =false;
        errorText = "Champ Username ne doit pas etre vide";
      });
    } else {
      var response =
          await networkHandler.get("/societe/checkUsername/${soc.username}");
      if (response['Status']) {
        setState(() {
          circular = false;
          validate = false;
          validate2 =false;
          errorText = "Username deja existe";
        });
      } else {
        setState(() {
          circular = false;
          validate = true;
          
        });
      }
    }
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
