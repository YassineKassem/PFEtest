// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../NetworkHandler.dart';
import '../../search/widgets/search_app_bar.dart';
import 'ProfileScreen.dart';


class EditPwd extends StatefulWidget {
  @override
  _EditPwd createState() => _EditPwd();
}

class _EditPwd extends State<EditPwd> {
  bool AlertError=false;
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  TextEditingController pwd =TextEditingController();
  TextEditingController checkPwd =TextEditingController();
  TextEditingController CurrentPwd =TextEditingController();
  
  NetworkHandler networkHandler= NetworkHandler();

  void updatePassword()async{
        Map<String, dynamic> data1 = {
      "password": CurrentPwd.text
    };
    var responseEdit1 = await networkHandler.post("/etudiant/checkEtdPassword",data1);
    if (responseEdit1.statusCode == 200 ||responseEdit1.statusCode == 201) {
      print('current pwd succes');
      Map<String, dynamic> data2 = {
      "password": pwd.text
    };
    var responseEdit2 = await networkHandler.patch("/etudiant/updatePwd",data2);
      if (responseEdit2.statusCode == 200 ||responseEdit2.statusCode == 201) {
        print('updated pwd succes');
        setState(() {AlertError=false;});
        _showDialog(context,"la procédure de modifcation mot de passe est terminé avec succée.",AlertError);                 
      }
      }
      else{
        setState(() {AlertError=true;});
        _showDialog(context,"Votre mot de passe actuelle est incorrecte.",AlertError);                 
      }
  
      
  }

    

 
  bool showPassword = false;
  bool showPassword2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Column(
        children: [
          SearchAppBar(),
          SizedBox(
          height: 50,
          ),
          Form(
            key: globalkey,
            child: Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Text(
                        "Changer mot de passe",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            controller: CurrentPwd,
                            validator: (value) {
                              if (value!.isEmpty) {
                              return 'Veuillez saisir votre mot de passe actuelle';
                              }
                              return null;
                              },
                            obscureText: true ? showPassword : false,
                            decoration: InputDecoration(
                            suffixIcon: true
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    labelText: "Mot de passe actuelle",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    )),
                          ),
                    ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                            controller: pwd,
                            validator: (value) {
                              if (value!.isEmpty) {
                              return 'Veuillez saisir votre nouvelle mot de passe';
                              }
                              return null;
                              },
                            obscureText: true ? showPassword : false,
                            decoration: InputDecoration(
                            suffixIcon: true
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    labelText: "Nouvelle Mot de passe",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "",
                    hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    )),
                          ),
                    ),
                    Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextFormField(
                          controller: checkPwd,
                          validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez confirmer votre mot de passe';
                              }
                              else if(checkPwd.text != pwd.text){
                                return 'Veuillez vous assurer que les deux mots de passe\n correspondent';
                              }
                              return null;
                              },
                            obscureText: true ? showPassword2 : false,
                            decoration: InputDecoration(
                            suffixIcon: true
                            ? IconButton(
                          onPressed: () {
                            setState(() {
                              showPassword2 = !showPassword2;
                            });
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      labelText: "Confirmer Mot de passe",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "",
                      hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    )),
                          ),
                    ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () { Navigator.pop(context);},
                            child: const Text("Annuler",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black)),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if(globalkey.currentState!.validate()){
                              updatePassword();
                              }
                              else{
                                print("password update failed");
                              }
                            },
                            color: Colors.grey,
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "Enregistrer",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
        
        ],
      ),
    );
  }
  _showDialog(BuildContext context,String text,bool Error){
  showDialog(
      context: context,
      builder: (BuildContext context){ 
         return CupertinoAlertDialog(
        title: Column(
          children: <Widget>[
            Text(text),
            
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              if(Error==true) {
                Navigator.of(context).pop();
              } else {
                Navigator.pushNamed(context,'/ProfileScreen');
              } 
            },),
        ],
      );
       });
}


}