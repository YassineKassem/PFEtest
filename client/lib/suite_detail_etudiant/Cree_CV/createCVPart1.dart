import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../AccueilEtd.dart';
import '../../NetworkHandler.dart';
import '../../model/CVmodel.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../signin.dart';
import 'display.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class createCVPart1 extends StatefulWidget {
  @override
  _createCVPart1State createState() => _createCVPart1State();
}

class _createCVPart1State extends State<createCVPart1> {

  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  
  int _currentStep = 0;
  String resultSlider = '';
  bool isComplete = false;
  NetworkHandler networkHandler=NetworkHandler();
  bool circular = false;


  final Nom = TextEditingController();
  final Prenom = TextEditingController();
  final Adressemail = TextEditingController();
  final Numerotel = TextEditingController();
  final Adresse = TextEditingController();
  final Codepostale = TextEditingController();
  final Ville = TextEditingController();
  final DescriptionP = TextEditingController();
  


  
    PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Créer votre CV',
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: Colors.red),
          ),
          child: Form(
            key: globalkey,
            child: Stepper(
              steps: _stepper(),
              onStepTapped: (int newIndex) {
                setState(() {
                  _currentStep = newIndex;
                });
              },
              currentStep: _currentStep,
              onStepContinue: ()async {
                final isLastStep = _currentStep == _stepper().length - 1;
                if (_currentStep != 1) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
                 else if (isLastStep) {
                    setState(() {
                    circular=true;
                  });
                  if (globalkey.currentState!.validate() && _imageFile?.path != null) {
                  Map<String, dynamic> data = {
                                "nom": Nom.text,
                                'Prenom': Prenom.text,
                                'email': Adressemail.text,
                                "Numerotel": int.parse(Numerotel.text),
                                'Adresse': Adresse.text,
                                'Codepostale': Codepostale.text,
                                'Ville': Ville.text,
                                'Profil':DescriptionP.text,
                  };
                  
                  var response =
                      await networkHandler.post("/cv/add", data);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    if (_imageFile?.path != null) {
                      var imageResponse = await networkHandler.patchImage(
                          "/cv/add/image", _imageFile!.path);
                      if (imageResponse.statusCode == 200) {
                        setState(() {
                          circular = false;
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => AccueilEtd()),
                            (route) => false);
                      }
                    } else {
                      
                      setState(() {
                        isComplete = true;
                        circular = false;
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => AccueilEtd()),
                          (route) => false);
                          }
                      }
                      
                      }else{
                        showAlertDialog(context,'Veuillez ajouter une image de profil');
                      }
                      
                      }
              },
              onStepCancel: () {
                if (_currentStep != 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return  Row(
            children: <Widget>[
              SizedBox(height: 70.0),
              Container(
                color: Colors.red,
                child: TextButton(
                  onPressed: details.onStepContinue,
                  child: _currentStep != 1? const Text('Continuer',
                  style: TextStyle(color: Colors.black)) : Text('Terminer',
                  style: TextStyle(color: Colors.black))),
              ),
              Container(
                color: Colors.white,
                child: TextButton(
                  onPressed: details.onStepCancel,
                  child: const Text('Retourner',
                  style: TextStyle(color: Colors.black) ,),
                ),
              ),
            ],
        
        );
      },
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        state: _currentStep > 0 &&
                Nom.text != '' &&
                Prenom.text != '' &&
                Adressemail.text != '' &&
                Numerotel.text != '' &&
                Adresse.text != '' &&
                Codepostale.text != '' &&
                Ville.text != ''
            ? StepState.complete
            : _currentStep > 0
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 0,
        title: Text('Détail personnels'),
        content: Column(
          children: [
            imageProfile(),
            SizedBox(
              height: 20,
            ),
            BuildTextField('Nom', Nom),
            BuildTextField('Prenom', Prenom),
            BuildTextField('Adresse e-mail', Adressemail),
            Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Numero de téléphone'),
          TextFormField(
            controller: Numerotel,
            decoration: InputDecoration(
              fillColor: Colors.white10, filled: true,
              border: OutlineInputBorder(),
              isDense: true, // Added this
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'enter votre numéro de telephone';
              }
              return null;
            },
          ),
        ],
      ),
    ),
            BuildTextField('Adresse', Adresse),
            BuildTextField('Code postale', Codepostale),
            BuildTextField('Ville', Ville),
          ],
        ),
      ),
      Step(
        state: _currentStep > 1 && DescriptionP.text != ''
            ? StepState.complete
            : _currentStep > 1
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 1,
        title: Text('Profil'),
        content: Column(
          children: [
            BuildlargeTextField('Description', DescriptionP),
          ],
        ),
      )
    ];
    return _steps;
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

  Widget imageProfile() {
    return Center(
      child: Stack(children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: _imageFile == null
              ? AssetImage('assets/images/avatar.png')
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
            child: Icon(Icons.camera_alt, color: Colors.black45, size: 28),
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

  Widget BuildTextField(String titre, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: c,
            decoration: InputDecoration(
              fillColor: Colors.white10, filled: true,
              border: OutlineInputBorder(),
              isDense: true, // Added this
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget BuildlargeTextField(String titre, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: c,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true, // Added this
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ],
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