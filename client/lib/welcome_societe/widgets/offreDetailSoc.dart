import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/Postuler/hero_dialog_route.dart';
import 'package:pfe/welcome_etudiant/Postuler/styles.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';
import 'package:pfe/welcome_societe/widgets/listStgiaires.dart';

import '../../NetworkHandler.dart';
import '../../model/offreStageModel.dart';



class offreDetailSoc extends StatefulWidget {
    final Stage stage;
    offreDetailSoc(this.stage);

  @override
  State<offreDetailSoc> createState() => _offreDetailSocState();
}

class _offreDetailSocState extends State<offreDetailSoc> {
  
   NetworkHandler networkHandler=NetworkHandler();
   final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    
    return Container(
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
                                NetworkHandler().getImage(widget.stage.societeId),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.stage.username as String,
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
                  widget.stage.nomOffre as String,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_city_outlined,
                        widget.stage.localisation as String),
                    IconText(Icons.access_time_filled_outlined,
                        widget.stage.duree as String),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.stage.descriptionOffre as String,
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => listStagiaires(widget.stage),
                       ));
                    },
                    child: const Text('Consulter étudiants postulés'),
                    
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



