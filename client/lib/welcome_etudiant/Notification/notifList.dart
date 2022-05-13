import 'package:flutter/material.dart';
import 'package:pfe/model/SuperModelPostulation.dart';

import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';




  

import 'Notif.dart';
import 'NotifItem.dart';class notifList extends StatefulWidget {
    const notifList({ Key? key }) : super(key: key);
  
    @override
    State<notifList> createState() => _notifListState();
  }
  
  class _notifListState extends State<notifList> {

  
    
  List<Notif> data = [
    Notif(id: 1,dateEnvoi: '11/05/2022',objet: 'Demande postulation accepter',message: 'Bonjour Ahmed, vous êtes le bienvenu dans notre société médianet pour passer un entretien technique A 12h le mercredi 20/05/2022.',nomSociete: 'medianet' ),
    Notif(id: 2,dateEnvoi: '02/05/2022',objet: 'Stage Cloud Keryus',message: 'Nous Sommes désolé mais votre demande de postulation n est pas acceptée.',nomSociete: 'Keryus' )
  ];



  @override
  Widget build(BuildContext context) {
    return data.isEmpty==false? Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Expanded(
          child: Container(
      margin: EdgeInsets.only(top: 25),
      child: ListView.separated(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    itemBuilder: (context, index) => GestureDetector(
              child: NotifItem(                
                data[index],
            )),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: data.length),
    )
    ),
    ]
    ): Column();
  }
  }
