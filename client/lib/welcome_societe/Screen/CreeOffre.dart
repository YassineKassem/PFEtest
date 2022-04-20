import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../NetworkHandler.dart';
import '../../model/MotCle.dart';
import '../../model/offreStageModel.dart';
import '../../search/widgets/search_app_bar.dart';
import '../kConst.dart';

class CreeOffre extends StatefulWidget {
  const CreeOffre({Key? key}) : super(key: key);

  @override
  State<CreeOffre> createState() => _CreeOffreState();
}

class _CreeOffreState extends State<CreeOffre> {
  bool AlertError=false;
  GlobalKey<FormState> globalkey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController NomOffre = TextEditingController();
  TextEditingController DescriptionOffre = TextEditingController();
  TextEditingController LieuOffre = TextEditingController();
  TextEditingController ExpirationOffre = TextEditingController();
  TextEditingController DureeStage = TextEditingController();
  TextEditingController Cle = TextEditingController();
  List<MotCle> listcle = [];
  List<String> recupererMotCle = [];

  List<MotCle> getListCle() {
    for (int i = 0; i < recupererMotCle.length; i++) {
      listcle.add(MotCle(cle: recupererMotCle[i]));
    }
    return listcle;
  }

  Future<void> CreateOffre() async {
    Map<String, dynamic> data = {
      "nomOffre": NomOffre.text,
      'descriptionOffre': DescriptionOffre.text,
      'localisation': LieuOffre.text,
      "dateExpiration": ExpirationOffre.text,
      'duree': DureeStage.text,
      'motClee': getListCle()
    };
    var response = await networkHandler.post("/offreStage/Add", data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("offre de stage ajouter avec succee");
      setState(() {
      AlertError=false;
      });
      _showDialog(context,"la création de l'offre de stage ${NomOffre.text} est términer avec succée. ",AlertError);
    }else{
      setState(() {
      AlertError=true;
      });
      _showDialog(context,"la création de l'offre de stage a échoué",AlertError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: globalkey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchAppBar(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: 300,
                  child: const Text(
                    'Créer mon offre de stage',
                    textAlign: TextAlign.center,
                    style: loginTitle,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: NomOffre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir le nom de l' 'offre';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.post_add_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Nom offre',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: DescriptionOffre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir la description de l' 'offre';
                      }
                      return null;
                    },
                    maxLines: 10,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.add_comment,
                          color: Colors.grey,
                        ),
                        hintText: 'Description offre ',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: LieuOffre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir le lieu stage';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.add_location_alt,
                          color: Colors.grey,
                        ),
                        hintText: 'Lieu stage',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: ExpirationOffre,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir la date d'
                            'expiration offre de stage';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
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
                          ExpirationOffre.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(
                        Icons.access_alarm_outlined,
                        color: Colors.grey,
                      ),
                      hintText: 'Expiration offre',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: DureeStage,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir la durée du stage';
                      }
                      return null;
                    },
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.access_alarm_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Durée stage',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF4A4A54),
                  ),
                  child: TextFormField(
                    controller: Cle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Vueillez saisir les mot cles de l'
                            'offre de stage';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      List<String> list = value.split(" ");
                      if (list.contains(" ")) {
                        list.remove(" ");
                      }
                      setState(() {
                        recupererMotCle = list;
                      });
                    },
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.key,
                          color: Colors.grey,
                        ),
                        hintText: 'Mots clées',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 40),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: const Color.fromARGB(255, 215, 168, 86),
                    ),
                    onPressed: () {
                      if (globalkey.currentState!.validate()) {
                        CreateOffre();
                      }
                    },
                    child: const Text('Ajouter un offre', style: button),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
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
                Navigator.pushNamed(context,'/AccueilSoc');
              } 
            },),
        ],
      );
       });
}

}
