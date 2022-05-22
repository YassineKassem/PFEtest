import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../AccueilSoc.dart';
import '../NetworkHandler.dart';

class formSociete extends StatefulWidget {
  const formSociete({ Key? key }) : super(key: key);

  @override
  State<formSociete> createState() => _formSocieteState();
}

class _formSocieteState extends State<formSociete> {
  bool AlertError=false;
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  int _currentStep = 0;
  bool isComplete =false;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final Nom=TextEditingController();
  final SecteurActivite=TextEditingController();
  final CodeFiscal=TextEditingController();
  final Email=TextEditingController();
  final EmailR=TextEditingController();
  final CodePostal=TextEditingController();
  final tel=TextEditingController();
  NetworkHandler networkHandler=NetworkHandler();
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Créer ma société',
          style: TextStyle(color:Colors.blue.shade300,) ,),
        backgroundColor: Colors.white,

      ),
      body:  Center(
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: Colors.blue.shade300,),
                ),
                child: Form(
                  key: globalkey,
                  child: Stepper(
                    steps: _stepper(),
                    onStepTapped: (int newIndex) {
                      setState(() {
                        _currentStep=newIndex;
                      });},
                    currentStep: _currentStep,
                    onStepContinue: ()async {
                      final isLastStep = _currentStep == _stepper().length -1;
                      if (_currentStep != 1) {
                        setState(() {
                          _currentStep += 1;
                        });
                      }
                      else if(isLastStep){
                        if (globalkey.currentState!.validate() && _imageFile?.path != null) {
                  Map<String, dynamic> data = {
                                "nom": Nom.text,
                                'SecteurActivite': SecteurActivite.text,
                                "CodeFiscal": CodeFiscal.text,
                                'Email': Email.text,
                                'EmailR': EmailR.text,
                                'CodePostal': CodePostal.text,
                                'tel':int.parse(tel.text),
                  };
                  var response =
                      await networkHandler.post("/profileSociete/add", data);
                  if (response.statusCode == 200 ||
                      response.statusCode == 201) {
                    if (_imageFile?.path != null) {
                      var imageResponse = await networkHandler.patchImage(
                          "/profileSociete/add/image", _imageFile!.path);
                      if (imageResponse.statusCode == 200) {
                        setState(() {
                          circular = false;
                          AlertError=false;
                        });

                        _showDialog(context,"la procédure d'inscription est terminé avec succée.\nBienvenue dans Sattegeny\n ${Nom.text}.",AlertError);

                      }
                    } else {
                      setState(() {
                        isComplete = true;
                        circular = false;
                        AlertError=false;
                      });
                      _showDialog(context,"la procédure d'inscription est terminé avec succée.\nBienvenue dans Sattegeny\n ${Nom.text}.",AlertError);
                      }
                      }
                      }else{
                       setState(() {
                            AlertError=true;
                           });
                        _showDialog(context,'Veuillez ajouter une image de profil et remplir tous les données',AlertError);
                      }
                      }
                    },
                    onStepCancel: (){

                      if(_currentStep!=0)
                      {
                        setState(() {
                          _currentStep -=1;
                        });
                      }
                    },

                  ),
                ),
              ),
            ),
    );
  }


  List<Step> _stepper(){
    List<Step> _steps=[

        Step(
          state: _currentStep > 0 && Nom.text!='' && SecteurActivite.text!='' && CodeFiscal.text!='' ? StepState.complete : _currentStep > 0?  StepState.error :StepState.indexed ,
          isActive: _currentStep>=0,
          title: Text('Informations générales'),
          content: Column(
            children: [
              imageProfile(),
              SizedBox(height: 20,),
              BuildTextField('Nom',Nom),
              BuildTextField('Secteur d activite', SecteurActivite),
              BuildTextField('Matricule Fiscal',CodeFiscal),
   
            ],
          ) ,
        ),
      Step(
        state: _currentStep > 1 && Email.text!='' && CodePostal.text!='' && tel.text!='' && EmailR.text!=''? StepState.complete : _currentStep > 1?  StepState.error :StepState.indexed ,
        isActive: _currentStep>=1,
        title: Text('Contact'),
        content: Column(
          children: [
              BuildTextField('Email',Email),
              BuildTextField('Code postal', CodePostal),
              BuildTextField('Telephone',tel),
              BuildTextField('Email Responsable',EmailR),
          ],
        ),
      ),
      ];
    return _steps;}

  Widget bottomSheet(){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin:EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'choisir logo société',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(onPressed: (){takePhoto(ImageSource.camera);}, icon: Icon(Icons.camera), label: Text('Camera')),
              FlatButton.icon(onPressed: (){takePhoto(ImageSource.gallery);}, icon: Icon(Icons.image), label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  Widget imageProfile()
  {
    return Center(
      child: Stack(
        children:[
          CircleAvatar(
            radius: 80,
            backgroundImage: _imageFile==null? AssetImage('assets/images/avatar.png'): FileImage(File(_imageFile!.path)) as ImageProvider,
          ),
          Positioned(
          bottom: 20,
          right: 20,
            child: InkWell(
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  builder: ((builder)=> bottomSheet()),
                );
              },
              child: Icon(
              Icons.camera_alt,
              color: Colors.black45,
              size:28
          ),
            ),)
        ]
      ),
    );
  }

  void takePhoto(ImageSource source)async{
    final pickerFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickerFile;
    });
  }

  Widget BuildTextField(String titre,TextEditingController c){
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,right: 15,left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: c,
            decoration: InputDecoration(
              fillColor: Colors.white10, filled: true,
              border: OutlineInputBorder(),
              isDense: true,                      // Added this
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
    );}


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
                Navigator.pushNamed(context,'/AccueilSoc');
              } 
            },),
        ],
      );
       });
}



}