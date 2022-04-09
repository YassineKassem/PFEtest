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
      circular = false;
       }); 
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                       //Navigator.of(context).push(MaterialPageRoute(
                       //builder: (context) => listStagiaires(widget.stage),
                       //));
                    },
                    child: const Text('Repondre étudiant'),
                    
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



