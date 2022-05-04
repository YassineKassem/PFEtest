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
          : Container(
      margin: EdgeInsets.symmetric(vertical: 25),
      height: 160,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 25),
          scrollDirection: Axis.horizontal,
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
                width: 15,
              ),
          itemCount: data.length),
    );
  
  }
}
