import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:pfe/AccueilSoc.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/model/Societe.dart';
import 'package:pfe/suite_detail_etudiant/Cree_CV/createCVPart1.dart';
import 'AccueilEtd.dart';
import 'NetworkHandler.dart';
import 'model/CVmodel.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  NetworkHandler networkHandler = NetworkHandler();
  final _formKey = GlobalKey<FormState>();
  Etudiant etd = new Etudiant('', '');
  Societe soc = new Societe('', '');
  String errorText = '';
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    String getUser() {
      String? route = ModalRoute.of(context)?.settings.name;

      String user = '';
      for (int i = 7; i < route!.length; i++) {
        user += route[i];
      }
      print(user);
      return user;
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.transparent,
        body: Stack(
            children: [
            
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Bienvenue\n${getUser()}',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4),
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
                                    ? TextEditingController(text: etd.username)
                                    : TextEditingController(text: soc.username),
                                onChanged: (value) {
                                  if (getUser() == 'etudiant')
                                    etd.username = value;
                                  else
                                    soc.username = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return errorText="Username invalid";
                                  }else{

                                  }
                                  return null;
                                },
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Username",
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
                                    return errorText="Password invalid";
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
                                                  validate=true;
                                                });
                                                if (_formKey.currentState!.validate() && validate) {   
                                                if (getUser() == 'etudiant') {
                                                  //Login Logic start here
                                                  Map<String, String> data = {
                                                    "username": etd.username,
                                                    "password": etd.password,
                                                  };
                                                  var response =
                                                      await networkHandler.post(
                                                          "/etudiant/login",
                                                          data);
        
                                                  if (response.statusCode ==
                                                          200 ||
                                                      response.statusCode ==
                                                          201) {
                                                    Map<String, dynamic> output =
                                                        json.decode(
                                                            response.body);
                                                    print(output["token"]);
                                                    await storage.write(
                                                        key: "token",
                                                        value: output["token"]);
                                                    setState(() {
                                                      validate = true;
                                                      circular = false;
                                                    });
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AccueilEtd(),
                                                        ),
                                                        (route) => false);
                                                  } else {
                                                    String output = json
                                                        .decode(response.body);
                                                    setState(() {
                                                      validate = false;
                                                      errorText = output;
                                                      circular = false;
                                                    });
                                                  }
                                                } else {
                                                  Map<String, String> data = {
                                                    "username": soc.username,
                                                    "password": soc.password,
                                                  };
                                                  var response =
                                                      await networkHandler.post(
                                                          "/societe/login", data);
        
                                                  if (response.statusCode ==
                                                          200 ||
                                                      response.statusCode ==
                                                          201) {
                                                    Map<String, dynamic> output =
                                                        json.decode(
                                                            response.body);
                                                    print(output["token"]);
                                                    await storage.write(
                                                        key: "token",
                                                        value: output["token"]);
                                                    setState(() {
                                                      validate = true;
                                                      circular = false;
                                                    });
                                                    Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AccueilSoc(),
                                                        ),
                                                        (route) => false);
                                                  } else {
                                                    String output = json
                                                        .decode(response.body);
                                                    setState(() {
                                                      validate = false;
                                                      errorText = output;
                                                      circular = false;
                                                    });
                                                  }
                                                }
                                                }else {
                                            print("not ok");
                                            setState(() {
                                              circular=false;
                                            });
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
              
            ],
          ),
        
      ),
    );
  }

  
}

