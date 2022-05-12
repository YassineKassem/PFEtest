import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../../AccueilEtd.dart';
import '../../NetworkHandler.dart';
import '../../model/CVmodel.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../model/ListCV.dart';
import '../../model/centreInteretModel.dart';
import '../../model/competanceModel.dart';
import '../../model/formationModel.dart';
import '../../model/langueModel.dart';
import '../../model/stageModel.dart';
import '../../signin.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';



class createCVPart1 extends StatefulWidget {
  @override
  _createCVPart1State createState() => _createCVPart1State();
}

class _createCVPart1State extends State<createCVPart1> {


  List<double> _currentSliderValue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  int index = 0;
  int indexFormation = 0;
  int indexLangue = 0;
  int indexci = 0;
  int indexS = 0;
  formation form =new formation();
  CVmodel profileModel = CVmodel();
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  bool AlertError =false;
  int _currentStep = 0;
  String resultSlider = '';
  bool isComplete = false;
  NetworkHandler networkHandler=NetworkHandler();
  bool circular = false;
  stage stg =new stage();
  langues lg =new langues();
  competance comp =new competance();
  Interet CI =new Interet();

  final Nom = TextEditingController();
  final Prenom = TextEditingController();
  final Adressemail = TextEditingController();
  final Numerotel = TextEditingController();
  final Adresse = TextEditingController();
  final Codepostale = TextEditingController();
  final Ville = TextEditingController();
  final DescriptionP = TextEditingController();
  
  List<TextEditingController> Formation = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> EtablissementF = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> VilleF = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DatedebutF = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DatefinF = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DescriptionF = List.generate(100, (i) => TextEditingController());

  TextEditingController DescriptionRealisation = TextEditingController();

  List<TextEditingController> competances = List.generate(100, (i) => TextEditingController());

  List<TextEditingController> langue = List.generate(10, (i) => TextEditingController());
  List<TextEditingController> centreInteret = List.generate(100, (i) => TextEditingController());

  List<TextEditingController> nomSociete = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DatedebutS = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DatefinS = List.generate(100, (i) => TextEditingController());
  List<TextEditingController> DescriptionS = List.generate(100, (i) => TextEditingController());
  

    @override
  void initState() {
    super.initState();
    comp.nomCompetance = List<String>.empty(growable: true);
    comp.nomCompetance!.add("");

    CI.centreInteret = List<String>.empty(growable: true);
    CI.centreInteret!.add("");

    form.nomFormation= List<String>.empty(growable: true) ;
    form.nomFormation!.add("");
    form.etablissementF = List<String>.empty(growable: true);
    form.etablissementF!.add("");
    form.villeF = List<String>.empty(growable: true);
    form.villeF!.add("");
    form.datedF = List<DateTime>.empty(growable: true);
    form.datedF!.add(DateTime.now());
    form.datefF = List<DateTime>.empty(growable: true);
    form.datefF!.add(DateTime.now());
    form.DescriptionF = List<String>.empty(growable: true);
    form.DescriptionF!.add("");

    lg.nomLangue = List<String>.empty(growable: true);
    lg.nomLangue!.add("");
    lg.NiveauLangue = List<String>.empty(growable: true);
    lg.NiveauLangue!.add("");

    stg.nomSociete = List<String>.empty(growable: true);
    stg.nomSociete!.add("");
    stg.datedS = List<DateTime>.empty(growable: true);
    stg.datedS!.add(DateTime.now());
    stg.datefS = List<DateTime>.empty(growable: true);
    stg.datefS!.add(DateTime.now());
    stg.DescriptionS = List<String>.empty(growable: true);
    stg.DescriptionS!.add("");
    
    
  }
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();


   
  getstage(){
     List<StageModel> f=[];
     profileModel.Stage=f;
      for (int i = 0; i < nomSociete.length; i++) {
        if (nomSociete[i].text != '')
          f.add(StageModel(nomSociete:nomSociete[i].text,datedS:DatedebutS[i].text ,datefS:DatefinS[i].text ,DescriptionS:DescriptionS[i].text));
      }
      return f;}

  getformation(){
    List<FormationModel> f=[];
    profileModel.Formations=f;
      for (int i = 0; i < Formation.length; i++) {
        if (Formation[i].text != '')
          {
          f.add(FormationModel(nomFormation:Formation[i].text,etablissementF:EtablissementF[i].text,
          villeF:VilleF[i].text,datedF:DatedebutF[i].text,
          datefF: DatefinF[i].text ,DescriptionF:DescriptionF[i].text));
          }
      }
      return f;}

    getcompetances(){
      List<CompetanceModel> f=[];
      profileModel.Competence=f;
      for (int i = 0; i < competances.length; i++) {
        if (competances[i].text != '')
          {
          print("${competances[i].text}******comp$i");
          f.add(CompetanceModel(nomCompetence:competances[i].text ));
          }
      }
      return f;
      }

    getinteret(){
    List<CentreInteretModel> f=[];
    profileModel.Ci=f;
    for (int i = 0; i < centreInteret.length; i++) {
        if (centreInteret[i].text != '')
          {
          f.add(CentreInteretModel(nomCi:centreInteret[i].text));
          }
      }
      return f;}
      
    getlangue(){
     List<LangueModel> f=[];
     profileModel.langue=f;
      for (int i = 0; i < langue.length; i++) {
       
        if (langue[i].text != '') {
          if (_currentSliderValue[i] == 10)
            resultSlider = 'Débutant(e)';
          else if (_currentSliderValue[i] == 20)
            resultSlider = 'Intermédiaire';
          else if (_currentSliderValue[i] == 30)
            resultSlider = 'Bien';
          else if (_currentSliderValue[i] == 40)
            resultSlider = 'Très bien';
          else if (_currentSliderValue[i] == 50)
            resultSlider = 'Excellent';
          else {
            resultSlider = '';
          }
          f.add(LangueModel(nomLangue:langue[i].text,NiveauLangue:resultSlider));
      }
      return f;}} 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Créer votre CV',
          style: TextStyle(color: Colors.blue.shade300,),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
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
                  _currentStep = newIndex;
                });
              },
              currentStep: _currentStep,
              onStepContinue: ()async {
                final isLastStep = _currentStep == _stepper().length - 1;
                if (_currentStep != 7) {
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
                                'Realisation':DescriptionRealisation.text,
                                'Formation': getformation(),
                                'Competence': getcompetances(),
                                'Stage': getstage(),
                                'Ci': getinteret(),
                                'langue': getlangue()
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
                          AlertError=false;
                        });
                        _showDialog(context,"la procédure d'inscription est terminé avec succée.\nBienvenue dans Sattegeny\n ${Nom.text} ${Prenom.text}",AlertError);
                      }
                    } else {
                      
                      setState(() {
                        isComplete = true;
                        circular = false;
                        AlertError=false;
                      });
                      _showDialog(context,"la procédure d''inscription est terminé avec succée.\nBienvenue dans Sattegeny\n ${Nom.text} ${Prenom.text}",AlertError);
                          }
                      }
                      
                      }else{
                         setState(() {
                            AlertError=true;
                           });
                        _showDialog(context,'Veuillez ajouter une image de profil et remplir au moins votre détails personnel',AlertError);
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
                color: Colors.blue.shade300,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
         generatecv().then((String result){openFile(result);});
        }, 
        label: const Text('Aperçu'),
        icon: const Icon(Icons.content_paste_search_rounded),
        backgroundColor: Color.fromARGB(255, 54, 171, 244),
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
      ),
      Step(
        state: _currentStep > 2 &&
                Formation[indexFormation].text != '' &&
                EtablissementF[indexFormation].text != '' &&
                VilleF[indexFormation].text != '' &&
                DatedebutF[indexFormation].text != '' &&
                DatefinF[indexFormation].text != '' &&
                DatedebutF[indexFormation].text != ''
            ? StepState.complete
            : _currentStep > 2
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 2,
        title: Text('Formation'),
        content: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, indexFormation) {
                  return Column(
                    children: [
                      formationUI(indexFormation),
                    ],
                  );
                },
                separatorBuilder: (context, indexFormation) => Divider(),
                itemCount: form.nomFormation!.length),
          ],
        ),
      ),
      Step(
        state: _currentStep > 3 && competances[index].text != ''
            ? StepState.complete
            : _currentStep > 3
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 3,
        title: Text('Competance'),
        content: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) { 
                  return Column(
                    children: [
                      competanceUI(index),
                    ],
                  );
                 
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: comp.nomCompetance!.length),
          ],
        ),
      ),
      Step(
        state: _currentStep > 4 && DescriptionRealisation.text != ''
            ? StepState.complete
            : _currentStep > 4
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 4,
        title: Text('Realisation'),
        content: Column(
          children: [
            BuildlargeTextField('Description', DescriptionRealisation),
          ],
        ),
      ),
      Step(
        state: _currentStep > 5 &&
                nomSociete[indexS].text != '' &&
                DatedebutS[indexS].text != '' &&
                DatefinS[indexS].text != '' &&
                DescriptionS[indexS].text != ''
            ? StepState.complete
            : _currentStep > 5
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 5,
        title: Text('Stage'),
        content: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, indexS) {
                  return Column(
                    children: [
                      stageUI(indexS),
                    ],
                  );
                },
                separatorBuilder: (context, indexS) => Divider(),
                itemCount: stg.nomSociete!.length),
          ],
        ),
      ),
      Step(
        state: _currentStep > 6 && langue[indexLangue].text != ''
            ? StepState.complete
            : _currentStep > 6
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 6,
        title: Text('Langue'),
        content: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, indexLangue) {
                  return Column(
                    children: [
                      LangueUI(indexLangue),
                    ],
                  );
                },
                separatorBuilder: (context, indexLangue) => Divider(),
                itemCount: lg.nomLangue!.length),
          ],
        ),
      ),
      Step(
        state: _currentStep > 7 && centreInteret[indexci].text != ''
            ? StepState.complete
            : _currentStep > 7
                ? StepState.error
                : StepState.indexed,
        isActive: _currentStep >= 7,
        title: Text('Centre d' 'interet'),
        content: Column(
          children: [
            ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, indexci) {
                  return Column(
                    children: [
                      centreInteretUI(indexci),
                      
                    ],
                  );
                },
                separatorBuilder: (context, indexci) => Divider(),
                itemCount: CI.centreInteret!.length),
          ],
        ),
      ),
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
            onChanged: (text){
              c.text=text;
            },
            decoration: InputDecoration(
              fillColor: Colors.white10, filled: true,
              border: OutlineInputBorder(),
              isDense: true, // Added this
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              
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
            onChanged: (text){
              c.text=text;
            },
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

  Widget formationUI(indexFormation) {
    return Column(children: [
      BuildTextField('Formation$indexFormation', Formation[indexFormation]),
      BuildTextField('Etablissement', EtablissementF[indexFormation]),
      BuildTextField('Ville', VilleF[indexFormation]),
      BuildDateTextField('Date debut', DatedebutF[indexFormation]),
      BuildDateTextField('Date fin', DatefinF[indexFormation]),
      BuildlargeTextField('Description', DescriptionF[indexFormation]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: indexFormation == form.nomFormation!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addFormationControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: indexFormation > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeFormationControl(indexFormation);
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }


  void addCompetanceControl() {
    setState(() {
      comp.nomCompetance!.add("");
    });
  }

  void removeCompetanceControl(index) {
    setState(() {
      if (comp.nomCompetance!.length > 1)
        comp.nomCompetance!.removeAt(index);
    });
  }

  void addcentreInteretControl() {
    setState(() {
      CI.centreInteret!.add("");
    });
  }

  void removecentreInteretControl(indexci) {
    setState(() {
      if (CI.centreInteret!.length > 1)
        CI.centreInteret!.removeAt(indexci);
    });
  }

  void addLangueControl() {
    setState(() {
      lg.nomLangue!.add("");
      lg.NiveauLangue!.add("");
    });
  }

  void removeLangueControl(indexLangue) {
    setState(() {
      if (lg.nomLangue!.length > 1) {
        lg.NiveauLangue!.removeAt(indexLangue);
        lg.nomLangue!.removeAt(indexLangue);
      }
    });
  }

  void addFormationControl() {
    setState(() {
      form.nomFormation!.add("");
      form.etablissementF!.add("");
      form.villeF!.add("");
      form.datedF!.add(DateTime.now());
      form.datefF!.add(DateTime.now());
      form.DescriptionF!.add("");
    });
  }

  void removeFormationControl(indexFormation) {
    setState(() {
      if (form.nomFormation!.length > 1) {
        form.nomFormation!.removeAt(indexFormation);
        form.etablissementF!.removeAt(indexFormation);
        form.villeF!.removeAt(indexFormation);
        form.datedF!.removeAt(indexFormation);
        form.datefF!.removeAt(indexFormation);
        form.DescriptionF!.removeAt(indexFormation);
      }
    });
  }

  void addStageControl() {
    setState(() {
      stg.nomSociete!.add("");
      stg.datedS!.add(DateTime.now());
      stg.datefS!.add(DateTime.now());
      stg.DescriptionS!.add("");
    });
  }

  void removeStageControl(indexS) {
    setState(() {
      if (stg.nomSociete!.length > 1) {
        stg.nomSociete!.removeAt(indexS);
        stg.datedS!.removeAt(indexS);
        stg.datefS!.removeAt(indexS);
        stg.DescriptionS!.removeAt(indexS);
      }
    });
  }
bool isNumeric(String str) {
  try{
    var value = double.parse(str);
  } on FormatException {
    return false;
  } finally {
    return true;
  }
}

  Widget BuildDateTextField(String titre, TextEditingController Date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: Date, //editing controller of this TextField
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true, // Added this
            ),
            readOnly:
                true, //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                      2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  Date.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ],
      ),
    );
  }

    Widget centreInteretUI(indexci) {
    return Column(children: [
      Row(
        children: [
          Flexible(
              child: BuildTextField(
                  'centreInteret$indexci', centreInteret[indexci])),
          Visibility(
            visible: indexci == CI.centreInteret!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addcentreInteretControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: indexci > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removecentreInteretControl(indexci);
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }

    Widget stageUI(indexS) {
    return Column(children: [
      BuildTextField('Nom Société$indexS', nomSociete[indexS]),
      BuildDateTextField('Date debut', DatedebutS[indexS]),
      BuildDateTextField('Date fin', DatefinS[indexS]),
      BuildlargeTextField('Description', DescriptionS[indexS]),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: indexS == stg.nomSociete!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addStageControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: indexS > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeStageControl(indexS);
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }

    Widget LangueUI(indexLangue) {
    return Column(children: [
      Row(
        children: [
          Flexible(
              child:
                  BuildTextField('Langue$indexLangue', langue[indexLangue])),
          Visibility(
            visible: indexLangue == lg.nomLangue!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addLangueControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: indexLangue > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeLangueControl(indexLangue);
                },
              ),
            ),
          ),
        ],
      ),
      Container(
          width: MediaQuery.of(context).size.width - 115,
          child: Text(
            'Niveau',
          )),
      Row(
        children: [
          Slider(
            value: _currentSliderValue[indexLangue],
            max: 50,
            divisions: 5,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue[indexLangue] = value;
              });
            },
          ),
          Text(_currentSliderValue[indexLangue] == 10
              ? 'Débutant(e)'
              : _currentSliderValue[indexLangue] == 20
                  ? 'Intermédiaire'
                  : _currentSliderValue[indexLangue] == 30
                      ? 'Bien'
                      : _currentSliderValue[indexLangue] == 40
                          ? 'Très bien'
                          : _currentSliderValue[indexLangue] == 50
                              ? 'Courant(e)'
                              : 'Fais un choix'),
        ],
      ),
    ]);
  }

    Widget competanceUI(index)
  { 
    return Column(
      children: [
      Row(
        children: [
          Flexible(
              child:BuildTextField('competance$index', competances[index])
                ),
          Visibility(
            visible: index == comp.nomCompetance!.length - 1,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
                onPressed: () {
                  addCompetanceControl();
                },
              ),
            ),
          ),
          Visibility(
            visible: index > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeCompetanceControl(index);
                },
              ),
            ),
          ),
        ],
      ),
    ]);
  }




  // creation cv

  Future<String> generatecv() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();
    //Draw rectangle
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
        pen: PdfPen(PdfColor(142, 170, 219, 255)));

    //Content
    final result = drawcontent(page, pageSize);
    //Save the PDF document

    //image
    if (_imageFile != null) {
      final imageData = File(_imageFile!.path).readAsBytesSync();
      final PdfBitmap image = PdfBitmap(imageData);
      page.graphics.setClip(
          path: PdfPath()..addEllipse(Rect.fromLTWH(400, 20, 100, 100)));
      page.graphics.drawImage(image, const Rect.fromLTWH(400, 20, 100, 100));
    }
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/report.pdf';
    final File file = File(path);
    await file.writeAsBytes((await document.save()));
    return file.path;
  }

  static Future openFile(String url) async {
    await OpenFile.open(url);
  }

  //Draws the invoice header
  Future<PdfLayoutResult> drawcontent(PdfPage page, Size pageSize) async {
    //font style
    PdfFont font = new PdfStandardFont(PdfFontFamily.courier, 12);

    // draw 2 rectangles
    page.graphics.drawRectangle(
        bounds: Rect.fromLTWH(0, 0, pageSize.width - 450, 765),
        brush: PdfSolidBrush(PdfColor(32, 32, 32)));
    page.graphics.drawRectangle(
        bounds:
            Rect.fromLTWH(pageSize.width - 450, 0, pageSize.width - 500, 765),
        brush: PdfSolidBrush(PdfColor(0, 204, 204)));

    // contentFont
    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 9);

    // fullName
    final String NPChamp = '${Nom.text} ${Prenom.text}\r\n\r\n';
   
    PdfTextElement(
            text: NPChamp.toUpperCase(),
            brush: PdfSolidBrush(PdfColor(0, 204, 204)),
            font: PdfStandardFont(PdfFontFamily.courier, 30))
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                120, 30, pageSize.width - 150, pageSize.height - 120));
    final NPsize = NPChamp.length + 60.0;

    // detail personnels
    String DetailPersonnel = '''${Numerotel.text}\n''';
    DetailPersonnel += '''${Adressemail.text}\n''';
    DetailPersonnel +=
        '''${Adresse.text} ${Codepostale.text} ${Ville.text}\n''';
    PdfTextElement(
            text: DetailPersonnel,
            brush: PdfSolidBrush(PdfColor(128, 128, 128)),
            font: font)
        .draw(
            page: page,
            bounds: Rect.fromLTWH(
                120, NPsize, pageSize.width - 150, pageSize.height - 120));
    final DetailPersonnelsize = NPsize + DetailPersonnel.length - 10;
    final Size contentSize = contentFont.measureString(NPChamp+DetailPersonnel);
    // profil
    final String ProfilChamp = '${DescriptionP.text}\r\n\r\n';
    PdfTextElement(
            text: ProfilChamp.trimLeft(),
            brush: PdfSolidBrush(PdfColor(96, 96, 96)),
            font: font)
        .draw(
            page: page,
            bounds: Rect.fromLTWH(120, /*DetailPersonnelsize +30*/140,
                pageSize.width - 150, pageSize.height - 120));
    final profilSize = ProfilChamp.length + DetailPersonnelsize -20;

    //initialisation variable
    String CIChamp2 = '';
    String FormationChampContent = '';
    String competancechamp2 = '';
    String Languechamp2 = '';
    String stageChamp2 = '';
    String RealisationChamp2 = '';
    String CompetanceChamp = 'Competance';
    String Languechamp = 'Langues';
    String stageChamp = 'Stage';
    String RealisationChamp = 'Realisation\n\n\n';
    String CIChamp = 'Centre d' 'interet\n\n\n';

    // formation
    if (Formation[0].text != '') {
      String FormationChamp = 'Formation';
      drawLine(page, 120, pageSize.width - 50, profilSize + 20);
      PdfTextElement(
              text: FormationChamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: PdfStandardFont(PdfFontFamily.courier, 15))
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, /*profilSize*/170, pageSize.width - 150,
                  pageSize.height - 120));
      for (int i = 0; i < Formation.length; i++) {
        if (Formation[i].text != '')
          FormationChampContent +=
              '''${Formation[i].text}| ${DatedebutF[i].text} ${DatefinF[i].text}\n${EtablissementF[i].text}, ${VilleF[i].text}\n${DescriptionF[i].text}\r\n\r\n''';
      }
      PdfTextElement(
              text: FormationChampContent.trim(),
              brush: PdfSolidBrush(PdfColor(96, 96, 96)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, profilSize + 30, pageSize.width - 150,
                  pageSize.height - 120));
    }
    final formationSize = profilSize + FormationChampContent.length - 20;
    //competance
    if (competances[0].text != '') {
      drawLine(page, 120, pageSize.width - 50, formationSize + 20);
      PdfTextElement(
              text: CompetanceChamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: PdfStandardFont(PdfFontFamily.courier, 15))
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, formationSize, pageSize.width - 150,
                  pageSize.height - 120));
      for (int i = 0; i < competances.length; i++) {
        if (competances[i].text != '')
          competancechamp2 += '''${competances[i].text}/''';
      }
      competancechamp2 += '\r\n\r\n';
      PdfTextElement(
              text: competancechamp2,
              brush: PdfSolidBrush(PdfColor(96, 96, 96)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, formationSize + 30,
                  pageSize.width - 150, pageSize.height - 120));
    }
    final CompetanceSize =
        formationSize + CompetanceChamp.length + competancechamp2.length + 10;
    //langue
    if (langue[0].text != '') {
      drawLine(page, 120, pageSize.width - 50, CompetanceSize + 20);
      PdfTextElement(
              text: Languechamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, CompetanceSize, pageSize.width - 230,
                  pageSize.height - 120));
      for (int i = 0; i < langue.length; i++) {
        if (langue[i].text != null) {
          if (_currentSliderValue[i] == 10)
            resultSlider = 'Débutant(e)';
          else if (_currentSliderValue[i] == 20)
            resultSlider = 'Intermédiaire';
          else if (_currentSliderValue[i] == 30)
            resultSlider = 'Bien';
          else if (_currentSliderValue[i] == 40)
            resultSlider = 'Très bien';
          else if (_currentSliderValue[i] == 50)
            resultSlider = 'Excellent';
          else {
            resultSlider = '';
          }
          if (langue[i].text != '')
            Languechamp2 += '''${langue[i].text}-$resultSlider\n''';
        }
      }
      Languechamp2 += '\r\n\r\n';
      PdfTextElement(
              text: Languechamp2,
              brush: PdfSolidBrush(PdfColor(96, 96, 96)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, CompetanceSize + 30,
                  pageSize.width - 230, pageSize.height - 120));
    }

    final LangueSize =
        Languechamp2.length + Languechamp.length + CompetanceSize + 20;
    // stage
    if (nomSociete[0].text != '') {
      drawLine(page, 120, pageSize.width - 50, LangueSize + 20);
      PdfTextElement(
              text: stageChamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: PdfStandardFont(PdfFontFamily.courier, 15))
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, LangueSize, pageSize.width - 150,
                  pageSize.height - 120));

      for (int i = 0; i < Formation.length; i++) {
        if (nomSociete[i].text != '')
          stageChamp2 +=
              '''${nomSociete[i].text}| ${DatedebutS[i].text} ${DatefinS[i].text}\n${DescriptionF[i].text}\r\n\r\n''';
      }
      PdfTextElement(
              text: stageChamp2.trim(),
              brush: PdfSolidBrush(PdfColor(96, 96, 96)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, LangueSize + 30, pageSize.width - 150,
                  pageSize.height - 120));
    }
    final stageContent =
        stageChamp.length + stageChamp2.length + LangueSize - 10;
    // realisation
    if (DescriptionRealisation.text != '') {
      drawLine(page, 120, pageSize.width - 50, stageContent + 20);
      PdfTextElement(
              text: RealisationChamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: PdfStandardFont(PdfFontFamily.courier, 15))
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, stageContent, pageSize.width - 230,
                  pageSize.height - 120));
      if (DescriptionRealisation.text != '')
        RealisationChamp2 = '-${DescriptionRealisation.text}\r\n\r\n';
      PdfTextElement(
              text: RealisationChamp2,
              brush: PdfSolidBrush(PdfColor(96, 96, 96)),
              font: font)
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, stageContent + 30,
                  pageSize.width - 150, pageSize.height - 120));
    }
    final RealisationContent =
        RealisationChamp.length + RealisationChamp2.length + stageContent - 10;
    // centre interet
    if (centreInteret[0].text != '') {
      drawLine(page, 120, pageSize.width - 50, RealisationContent + 20);
      PdfTextElement(
              text: CIChamp.toUpperCase(),
              brush: PdfSolidBrush(PdfColor(64, 64, 64)),
              font: PdfStandardFont(PdfFontFamily.courier, 15))
          .draw(
              page: page,
              bounds: Rect.fromLTWH(120, RealisationContent,
                  pageSize.width - 230, pageSize.height - 120));
      for (int i = 0; i < centreInteret.length; i++) {
        if (centreInteret[i].text != '')
          CIChamp2 += '-${centreInteret[i].text}\n';
      }
    }

    return PdfTextElement(
            text: CIChamp2,
            brush: PdfSolidBrush(PdfColor(96, 96, 96)),
            font: font)
        .draw(
            page: page,
            bounds: Rect.fromLTWH(120, RealisationContent + 30,
                pageSize.width - 150, pageSize.height - 120));
  }

  void drawLine(PdfPage page, double t1, double t2, double h1) {
    final PdfPen linePen =
        PdfPen(PdfColor(0, 204, 204), dashStyle: PdfDashStyle.solid);
    linePen.dashPattern = <double>[1, 1];
    //Draw line
    page.graphics.drawLine(linePen, Offset(t1, h1), Offset(t2, h1));
  }

}
