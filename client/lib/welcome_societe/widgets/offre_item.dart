import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';
import '../../NetworkHandler.dart';
import '../../model/offreStageModel.dart';
import '../Dashboard.dart';
import '../Screen/CreeOffre.dart';
import '../Screen/ModifierOffre.dart';


class OffreItem extends StatefulWidget {
  final Stage stage;
  OffreItem(this.stage);
 

  @override
  State<OffreItem> createState() => _OffreItemState();

}

class _OffreItemState extends State<OffreItem> {
   NetworkHandler networkHandler=NetworkHandler();
   
  void SupprimerOffre() async{
   var response = await networkHandler.delete("/offreStage/delete/${widget.stage.id}");
    if (response.statusCode ==200 ||response.statusCode ==201){
      print("offre supprimer");
    }
    else{
       print("error dans lors du suppression offre");
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => {
                  
                },
                child: Row(
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
                    backgroundImage:NetworkHandler().getImage("${widget.stage.societeId}"),
                  ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.stage.username as String,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MofifierOffre(widget.stage)),
          );
        } else if (result == 1) {
          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      itemBuilder: ((context) => [
                  PopupMenuItem(
                      child: ListTile(
                        title: Text("Modifier"),
                        leading: Icon(
                          CupertinoIcons.pencil_ellipsis_rectangle,
                        ),
                      ),
                      value: 0),
                  PopupMenuItem(
                      child: ListTile(
                        title: Text(
                          "Supprimer",
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () { setState(() {
                         SupprimerOffre();
                      });
                       },
                      value: 1,
                      ),
                ]),
    )

            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.stage.nomOffre as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, widget.stage.localisation as String),
              IconText(Icons.access_time_outlined, widget.stage.duree as String),
            ],
          )
        ],
      ),
    );
  }
}

