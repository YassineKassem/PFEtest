import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/Postuler/hero_dialog_route.dart';
import 'package:pfe/welcome_etudiant/Postuler/styles.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';
import 'package:pfe/welcome_societe/widgets/listStgiaires.dart';
import '../../NetworkHandler.dart';
import '../../model/Etudiant.dart';
import '../../model/offreStageModel.dart';
import '../../model/postulation.dart';
import 'package:intl/intl.dart';

import '../../welcome_etudiant/Profile/ViewPDF.dart';

class StagiaireDetail extends StatefulWidget {
    final Etudiant etd;
    final Stage stage;
    StagiaireDetail(this.etd,this.stage);
    

  @override
  State<StagiaireDetail> createState() => _StagiaireDetailState();
}

class _StagiaireDetailState extends State<StagiaireDetail> {
  
   NetworkHandler networkHandler=NetworkHandler();
   final _formKey = GlobalKey<FormState>();
   postulation postule=postulation();
   bool circular=true;
   TextEditingController objetControl=TextEditingController();
   TextEditingController messageControl=TextEditingController();
   TextEditingController dateControl=TextEditingController();
   late String url;
  @override
  void initState() {
    super.initState();

    fetchDataPostulation();
  }
   void fetchDataPostulation()async{
     print(widget.etd.id);
     print(widget.stage.id);
      var response = await networkHandler.get("/postulations/PostulationByEtdAndOffre/${widget.etd.id}/${widget.stage.id}");
      if (!mounted) return;
      setState(() {
      postule = postulation.fromJson(response["data"]);
      url =networkHandler.getCV('${widget.etd.id}');
      circular = false;
       }); 
   }

   void Repondre(String message,String objet,String date)async{
     Map<String, dynamic> data = {
    "objet": objet,
    "message": message,
    "date":date 
    };
    var response = await networkHandler.post("/repondreEtudiant/AddReponse/${postule.id}",data);
   }

  @override
  Widget build(BuildContext context) {
    
    return circular
          ? Center(child: CircularProgressIndicator())
          :Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight:  Radius.circular(30),
          )),
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 60,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkHandler().getImage(widget.etd.id as String),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.etd.username as String,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.etd.email as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  postule.objet as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  postule.message as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //SizedBox(
               //   height: 30,
               // ),
               // Text(
               //   widget.stage.motClee as String,
                //  style: TextStyle(
                //    fontWeight: FontWeight.bold,
                //  ),
               // ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            icon: const Icon(Icons.remove_red_eye,size:12),
                            label: const Text(
                            '  Consulter CV  ',
                            style: TextStyle( color: Colors.white)
                            ),
                        onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(
                             builder: (context) => ViewPdf(url),
                           ));
                        }),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: () {
                           
                          Navigator.of(context).push(
                            HeroDialogRoute(builder: (context) {
                              return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Color.fromARGB(255, 67, 177, 183),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: objetControl,
                            decoration: InputDecoration(
                              hintText: 'Objet',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.5,
                          ),
                          TextFormField(
                            controller: messageControl,
                            decoration: InputDecoration(
                              hintText: 'Saisir votre Message',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                            maxLines: 10,
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 0.5,
                          ),
                          TextFormField(
                            controller: dateControl,
                            decoration: InputDecoration(
                              hintText: 'Saisir date entretien',
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
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
                              dateControl.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                          ),
                         const Divider(
                            color: Colors.white,
                            thickness: 0.5,
                          ),
                          FlatButton(
                            onPressed: () {
                                Repondre(objetControl.text,messageControl.text,dateControl.text);
                                 
                            },
                            child: const Text('Envoyer'),
                          ),
                        ],
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
                            }),
                          );
                        
                        },
                        child: const Text('Répondre étudiant'),
                        
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}

const String _heroAddTodo = 'add-todo-hero';

