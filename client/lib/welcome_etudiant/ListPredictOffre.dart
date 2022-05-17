// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/stage_detail.dart';
import 'package:pfe/welcome_etudiant/stage_item.dart';

import '../NetworkHandler.dart';
import '../model/SuperModelOffreStage.dart';
import '../model/offreStageModel.dart';
import '../model/recommendationOffre.dart';
import 'itemPredictOffre.dart';

class ListPredictOffre extends StatefulWidget {
  const ListPredictOffre({ Key? key }) : super(key: key);

  @override
  State<ListPredictOffre> createState() => _ListPredictOffreState();
}

class _ListPredictOffreState extends State<ListPredictOffre> {
  
    NetworkHandler networkHandler=NetworkHandler();
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();
    bool circular = true;
    List<Stage> data=[]; 
    List<double> ScoreList=[]; 
    recommendationOffre recomd = recommendationOffre();
    TextEditingController nb=TextEditingController();
    @override
    void initState() {
      fetchData();
      
    }

    void fetchData() async {
    var response = await networkHandler.get("/offreStage/PredictBestOffre");
    superModelOffre = SuperModelOffreStage.fromJson(response);
     if (!mounted) return;
    setState(() {
      data = superModelOffre.data!;
      fetchOffrePredicted(data);

    });
    }

    void fetchOffrePredicted(List<Stage> List) async {
      for(int i=0; i<List.length;i++){
    var response = await networkHandler.get("/predictOffre/listRecommendationByOffre/${List[i].id}");
    
     if (!mounted) return;
    setState(() {
      recomd = recommendationOffre.fromJson(response["data"]);
      ScoreList.add(recomd.score as double);
      
    });
     }
     setState(() {
       circular = false;
     });



    }



  
    @override
  Widget build(BuildContext context) {
    return circular
          ? Center(child: CircularProgressIndicator())
          : Expanded(
            child: Column(

              children: [
      //start appBar

        Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 25,
          right: 25,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (() {
                Navigator.of(context).pop();
              }),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                  PopupMenuButton(
    iconSize: 30,
    icon: Icon(
      Icons.filter_alt_rounded, // CHOOSE YOUR CUSTOM ICON
      color: Colors.black,
    ),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          enabled: true, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width:190,
                height: 50,
                child: TextFormField (  
                  controller: nb,
                  
                  decoration: InputDecoration( 
                  label: const Text(
                  'Saisir nombre d offres à afficher',
                   ), 
                  border: InputBorder.none,  
                  ),  
                  ),
              ),
                ElevatedButton(  
                            style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                            child: Text('Appliquer'), 
                   
                            onPressed: (){},  
                ) 
            ],
          ),
        ),
      ];
    },
  ),
                Container(
                  margin: EdgeInsets.only(top: 30, right: 10),
                  transform: Matrix4.rotationZ(100),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: (){
                           
                        },
                        child: Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.more_horiz_outlined),
              ],
            )
          ],
        )),

            //end appBar
                Container(
                    margin: EdgeInsets.symmetric(vertical: 25),
                    height: 160,
                    child: ListView.separated(
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                       
                itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => JobDetail(data[index]));
                    },
                    child: itemPredictOffre(                
                      data[index],ScoreList[index]
                  )),
                separatorBuilder: (_, index) => SizedBox(
                      height: 20,
                    ),
                itemCount: data.length),
                  ),
              ],
            ),
          );
  
  }
}
