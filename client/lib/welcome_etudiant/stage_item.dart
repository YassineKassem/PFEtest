import 'package:flutter/material.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';

import '../NetworkHandler.dart';
import '../model/CVmodel.dart';
import '../model/SuperModelOffreStage.dart';
import '../model/offreStageModel.dart';




class JobItem extends StatefulWidget {
  final Stage stage;
  JobItem(this.stage);

  @override
  State<JobItem> createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {

  
  NetworkHandler networkHandler= NetworkHandler();
  Etudiant profileModel = Etudiant();
  String username='';
  String nomOffre='';
  Etudiant etd =Etudiant();
  bool colorFav =false;
  SuperModelOffreStage superModelOffre =SuperModelOffreStage();
  List<Stage> data=[]; 
  @override
    void initState() {
      fetchDataOffreList();
      
    }

  void fetchData(String username, String nomOffre) async {
    Map<String, dynamic> data = {};
    var response = await networkHandler.patch("/favoris/AddFavaoris/$username/$nomOffre",data);
     print(response.statusCode);
     if (response.statusCode == 200 || response.statusCode == 201) {
        print('updated succes');}
  }
  
  void fetchDataOffreList() async {
    var response = await networkHandler.get("/favoris/list");
     superModelOffre= SuperModelOffreStage.fromJson(response);
    setState(() {
      data = superModelOffre.data!;
      IconFavorie();
    });
    
  }

   IconFavorie(){
    for( int i=0; i<data.length;i++)
    {
      if(data[i].username==widget.stage.username && data[i].nomOffre==widget.stage.nomOffre)
      {
        setState(() {
          colorFav=true;
        });
        
      }
    }
    

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white
      ),
      child: Column(
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
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: CircleAvatar(
                    radius: 20,
                    backgroundImage:NetworkHandler().getImage("${widget.stage.username}"),
                  ),
                  ),
                  SizedBox(width: 10,),
                  Text(widget.stage.username as String,
                  style:TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    
                  ),
                  )
                ],
              ),
               GestureDetector(
                onTap: (){
                  setState(() {
                      username=widget.stage.username as String;
                      nomOffre=widget.stage.nomOffre as String;
                  });
                  fetchData(username,nomOffre);
                },
                 child: Icon(
                 Icons.favorite,
                 color: colorFav?Colors.pink: Colors.black,
                 size: 24.0,
                    ),
               ),
            ],
          ),
          SizedBox(height: 15,),
          Text(widget.stage.nomOffre as String,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, widget.stage.localisation as String),
              //IconText(Icons.access_time_outlined, offre.dateExpiration as String),
              

            ],
          )


      ]),
    );
  }
}
