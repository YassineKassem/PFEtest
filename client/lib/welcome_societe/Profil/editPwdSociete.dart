import 'package:flutter/material.dart';
import '../../NetworkHandler.dart';
import '../../search/widgets/search_app_bar.dart';
import 'profilScreenSociete.dart';


class EditPwdSoc extends StatefulWidget {
  @override
  _EditPwdSoc createState() => _EditPwdSoc();
}

class _EditPwdSoc extends State<EditPwdSoc> {
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  TextEditingController pwd =TextEditingController();
  TextEditingController checkPwd =TextEditingController();
  NetworkHandler networkHandler= NetworkHandler();

  void updatePassword()async{
    Map<String, dynamic> data = {
      "password": pwd.text
    };
    var responseEdit = await networkHandler.patch("/societe/updatePwd",data);
      if (responseEdit.statusCode == 200 ||responseEdit.statusCode == 201) {
        print('updated succes');
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
                    labelText: "Password",
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
                      labelText: "Confirmer password",
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
                               Navigator.of(context).push(MaterialPageRoute(
                               builder: (context) => ProfileScreenSoc(),
                              )); 
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

}