import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pfe/AccueilEtd.dart';
import 'package:pfe/AccueilSoc.dart';
import '../../NetworkHandler.dart';
import '../../model/Societe.dart';
import '../../model/detailSociete.dart';
import '../../search/widgets/search_app_bar.dart';

class EditProfileSoc extends StatefulWidget {
  @override
  _EditProfileSoc createState() => _EditProfileSoc();
}

class _EditProfileSoc extends State<EditProfileSoc> {
  bool circular = true;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool showPassword = false;
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController emailEdit = TextEditingController();
  DetailSociete profileModel = DetailSociete();
  Societe soc=Societe();
  
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
                        buildTextField("E-mail", "${soc.email}", false, emailEdit),
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
                                          "/profileSociete/add/image", _imageFile!.path);
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
                                  "/societe/updateSociete",data);
                                if (responseEdit.statusCode == 200 ||
                                    responseEdit.statusCode == 201) {
                                  print("ok");
                                  //refreshpage
                                  Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => AccueilSoc()),
                                  (Route<dynamic> route) => false,
                                  );
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
              ? NetworkHandler().getImage("${profileModel.societeId}")
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
        controller: control..text=placeholder,
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
}