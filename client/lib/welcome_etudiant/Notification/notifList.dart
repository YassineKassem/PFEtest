import 'package:flutter/material.dart';
import 'package:pfe/model/SuperModelPostulation.dart';
import 'package:pfe/model/SuperModelRepondre.dart';
import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';
import '../../NetworkHandler.dart';
import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import '../../model/repondreEtudiant.dart';
import 'Notif.dart';
import 'NotifItem.dart';


  class notifList extends StatefulWidget {
    const notifList({ Key? key }) : super(key: key);
  
    @override
    State<notifList> createState() => _notifListState();
  }
  
  class _notifListState extends State<notifList> {


    NetworkHandler networkHandler=NetworkHandler();
    SuperModelRepondre ListReponse =SuperModelRepondre();
    List<repondreEtudiant> datarepondreEtudiant=[]; 
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();
    List<Stage> datarepondreoffre=[]; 

       @override
    void initState() {
      fetchDataReponseList();
      
      
    }
   void fetchDataReponseList() async {
    var response = await networkHandler.get("/repondreEtudiant/listReponseEtd");
     ListReponse= SuperModelRepondre.fromJson(response);
    setState(() {
      datarepondreEtudiant = ListReponse.data!;
      fetchDataReponseoffreList();
    });
   }
    void fetchDataReponseoffreList() async {
    var response2 = await networkHandler.get("/repondreEtudiant/listReponseEtdOffre");
     superModelOffre= SuperModelOffreStage.fromJson(response2);
    setState(() {
      datarepondreoffre = superModelOffre.data!;
      
    });
   }

  @override
  Widget build(BuildContext context) {
    return datarepondreEtudiant.isEmpty==false && datarepondreoffre.isEmpty==false ? Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Expanded(
          child: Container(
      margin: EdgeInsets.only(top: 25),
      child: ListView.separated(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    itemBuilder: (context, index) => GestureDetector(
              child: NotifItem(                
                datarepondreEtudiant[index],datarepondreoffre[index]
            )),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: datarepondreEtudiant.length),
    )
    ),
    ]
    ): Column(
      children: [
        Center(
        child: Text(
          "Liste des notifications est vide",
          textAlign: TextAlign.center,
        ),
      ),
      ],
    );
  }
  }


  