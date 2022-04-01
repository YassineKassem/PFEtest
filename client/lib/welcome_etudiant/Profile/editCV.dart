import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe/model/competanceModel.dart';
import '../../model/CVmodel.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import '../../model/ListCV.dart';
import '../../model/centreInteretModel.dart';
import '../../model/formationModel.dart';
import '../../model/langueModel.dart';
import '../../model/stageModel.dart';
import '../../suite_detail_etudiant/Cree_CV/display.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../NetworkHandler.dart';


class createCV extends StatefulWidget {
  @override
  _createCVState createState() => _createCVState();
}

class _createCVState extends State<createCV> {
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler= NetworkHandler();
  formation form =new formation();
  stage stg =new stage();
  langues lg =new langues();
  competance comp =new competance();
  Interet CI =new Interet();
  CVmodel profileModel = CVmodel();
  bool circular = true;
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  CompetanceModel CompetanceM=CompetanceModel();
  List<CompetanceModel> complist=[];



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
    fetchData(); 
  }

  void fetchData() async {
    var response = await networkHandler.get("/cv/getData");
    setState(() {
      profileModel= CVmodel.fromJson(response["data"]);
      circular = false;
    });
  }

  int _currentStep = 0;
  int index = 0;
  int indexFormation = 0;
  int indexLangue = 0;
  int indexci = 0;
  int indexS = 0;

  String resultSlider = '';
  bool isComplete = false;

  List<double> _currentSliderValue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  final Nom = TextEditingController();
  final Prenom = TextEditingController();
  final Adressemail = TextEditingController();
  final Numerotel = TextEditingController();
  final Adresse = TextEditingController();
  final Codepostale = TextEditingController();
  final Ville = TextEditingController();

  final Formation = List.generate(100, (i) => TextEditingController());
  final EtablissementF = List.generate(100, (i) => TextEditingController());
  final VilleF = List.generate(100, (i) => TextEditingController());
  final DatedebutF = List.generate(100, (i) => TextEditingController());
  final DatefinF = List.generate(100, (i) => TextEditingController());
  final DescriptionF = List.generate(100, (i) => TextEditingController());

  final DescriptionP = TextEditingController();

  final DescriptionRealisation = TextEditingController();

  final competances = List.generate(100, (i) => TextEditingController());

  final langue = List.generate(10, (i) => TextEditingController());
  final centreInteret = List.generate(100, (i) => TextEditingController());

  final nomSociete = List.generate(100, (i) => TextEditingController());
  final DatedebutS = List.generate(100, (i) => TextEditingController());
  final DatefinS = List.generate(100, (i) => TextEditingController());
  final DescriptionS = List.generate(100, (i) => TextEditingController());

  
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
          style: TextStyle(color: Colors.red),
        ),
        backgroundColor: Colors.white,
                leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.red,
          ),
          onPressed: () { Navigator.pop(context);},
        ),
      ),
      body: circular
          ? Center(child: CircularProgressIndicator())
          : Center(
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
                if (_currentStep != 7) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
                 else if (isLastStep) {
                    setState(() {
                    circular=true;
                  });
                  if (globalkey.currentState!.validate()) {
                   // Navigator.pushNamed(context, '/AccueilEtd');
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
                    var responseEdit = await networkHandler.patch(
                      "/cv/update",
                      data);
                      if (responseEdit.statusCode == 200 ||
                      responseEdit.statusCode == 201) {
                        print('updated succes');
                      }
                      setState(() {
                        circular = false;
                      });
                     
                  } else {
                      print('no');
                    setState(() {
                      circular=false;
                      isComplete = true;
                    });
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
        backgroundColor: Colors.red,
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
            BuildTextField('Nom', Nom,profileModel.nom ),
            BuildTextField('Prenom', Prenom,profileModel.Prenom),
            BuildTextField('Adresse e-mail', Adressemail,profileModel.email),
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
              }else if(isNumeric(value)==false)
                return 'le numéro de telephone doit etre numeric';
              return null;
            },
          ),
        ],
      ),
    ),
            BuildTextField('Adresse', Adresse,profileModel.Adresse),
            BuildTextField('Code postale', Codepostale,profileModel.Codepostale),
            BuildTextField('Ville', Ville,profileModel.Ville),
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
            BuildlargeTextField('Description', DescriptionP,profileModel.Profil),
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
            BuildlargeTextField('Competance', DescriptionRealisation,""),
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
            BuildlargeTextField('Description', DescriptionRealisation,""),
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

  Widget BuildTextField(String titre, TextEditingController c,String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: c..text=value as String,
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

  Widget BuildlargeTextField(String titre, TextEditingController c,String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 15, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titre),
          TextFormField(
            controller: c..text=value as String,
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
  stepperComp(m){
      
       ListView.separated(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, m) {
                  return Column(
                    children: 
                      [
                        Column(children: [
      Row(
        children: [
          Flexible(
              child:BuildTextField('competance$m', competances[m],profileModel.Competence![m].nomCompetence),
                ),
          Visibility(
            visible: m == profileModel.Competence!.length - 1,
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
            visible: m > 0,
            child: SizedBox(
              width: 35,
              child: IconButton(
                icon: Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
                onPressed: () {
                  removeCompetanceControl(m);
                },
              ),
            ),
          ),
        ],
      ),
    ]),
                      ],                   
                  );
                },
                separatorBuilder: (context, i) => Divider(),
                itemCount: comp.nomCompetance!.length);
                
     
    
  }


  Widget centreInteretUI(indexci) {
    return Column(children: [
      Row(
        children: [
          Flexible(
              child: BuildTextField(
                  'centreInteret$indexci', centreInteret[indexci],null)),
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

  Widget LangueUI(indexLangue) {
    return Column(children: [
      Row(
        children: [
          Flexible(
              child:
                  BuildTextField('Langue$indexLangue', langue[indexLangue],null)),
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

  Widget formationUI(indexFormation) {
    return Column(children: [
      BuildTextField('Formation$indexFormation', Formation[indexFormation],null),
      BuildTextField('Etablissement', EtablissementF[indexFormation],null),
      BuildTextField('Ville', VilleF[indexFormation],null),
      BuildDateTextField('Date debut', DatedebutF[indexFormation]),
      BuildDateTextField('Date fin', DatefinF[indexFormation]),
      BuildlargeTextField('Description', DescriptionF[indexFormation],null),
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

  Widget stageUI(indexS) {
    return Column(children: [
      BuildTextField('Nom Société$indexS', nomSociete[indexS],null),
      BuildDateTextField('Date debut', DatedebutS[indexS]),
      BuildDateTextField('Date fin', DatefinS[indexS]),
      BuildlargeTextField('Description', DescriptionS[indexS],null),
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
    final Size contentSizeNP = contentFont.measureString(NPChamp);
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

    // profil
    final String ProfilChamp = '${DescriptionP.text}\r\n\r\n';
    PdfTextElement(
            text: ProfilChamp.trimLeft(),
            brush: PdfSolidBrush(PdfColor(96, 96, 96)),
            font: font)
        .draw(
            page: page,
            bounds: Rect.fromLTWH(120, DetailPersonnelsize,
                pageSize.width - 150, pageSize.height - 120));
    final profilSize = ProfilChamp.length + DetailPersonnelsize - 20;

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
              bounds: Rect.fromLTWH(120, profilSize, pageSize.width - 150,
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
