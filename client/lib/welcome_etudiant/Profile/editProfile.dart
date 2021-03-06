import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/AccueilEtd.dart';
import 'package:pfe/welcome_etudiant/Profile/ProfileScreen.dart';

import '../../NetworkHandler.dart';
import '../../model/CVmodel.dart';
import '../../model/Etudiant.dart';
import '../../search/widgets/search_app_bar.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  bool AlertError=false;
  bool circular = true;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool showPassword = false;
  NetworkHandler networkHandler = NetworkHandler();
  CVmodel profileModel = CVmodel();
  Etudiant etd = Etudiant();
  TextEditingController emailEdit = TextEditingController();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/cv/getData");
    setState(() {
      profileModel = CVmodel.fromJson(response["data"]);
      circular = false;
    });

    var response2 =
        await networkHandler.get("/etudiant/");
    setState(() {
      etd = Etudiant.fromJson(response2["data"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: circular
          ? Center(child: CircularProgressIndicator())
          : Column(
            children: [
          SearchAppBar(),
          SizedBox(
          height: 50,
          ),
              Container(
                  padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "Modifier Profil",
                          style:
                              TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Center(
                                child: Stack(children: [
                                  imageProfile(),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        buildTextField("E-mail", etd.email as String, false, emailEdit),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlineButton(
                              padding: EdgeInsets.symmetric(horizontal: 35),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Annuler",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.black)),
                            ),
                            RaisedButton(
                              onPressed: () async {
                                if (_imageFile?.path != null) {
                                  var imageResponse =
                                      await networkHandler.patchImage(
                                          "/cv/add/image", _imageFile!.path);
                                  if (imageResponse.statusCode == 200) {
                                    print('true');
                                    setState(() {
                                      circular = false;
                                    });
                                  }
                                }
                                Map<String, dynamic> data = {
                                  'email': emailEdit.text,
                                };
                                var responseEdit = await networkHandler.patch(
                                    "/etudiant/updateEtudiant",
                                    data);
                                if (responseEdit.statusCode == 200 ||
                                    responseEdit.statusCode == 201) {
                                  print("ok");
                                  setState(() {
                                  AlertError=false;
                                  });
                            _showDialog(context,"modification profile est termin?? avec succ??e",AlertError);
                            
                                }
                              },
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 35),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
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
            ],
          ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _imageFile == null
              ? NetworkHandler().getImage("${profileModel.etudiantId}")
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(Icons.edit, color: Colors.black45, size: 28),
          ),
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickerFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickerFile;
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'choisir une photo',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Widget buildTextField(String valeur, String placeholder,
      bool isPasswordTextField, TextEditingController control) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        initialValue: placeholder,
            onChanged: (text){
              control.text=text;
            },
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
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
                Navigator.pushNamed(context,'/AccueilEtd');
              } 
            },),
        ],
      );
       });
}


}