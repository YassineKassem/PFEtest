import 'package:flutter/material.dart';
import 'package:pfe/model/SuperModelPostulation.dart';

import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';

import '../../NetworkHandler.dart';

import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import '../../model/postulation.dart';
import '../../stage_detail.dart';
import 'package:pfe/model/Etudiant.dart';



  class PostulationsList extends StatefulWidget {
    const PostulationsList({ Key? key }) : super(key: key);
  
    @override
    State<PostulationsList> createState() => _PostulationsListState();
  }
  
  class _PostulationsListState extends State<PostulationsList> {

    NetworkHandler networkHandler=NetworkHandler();
    Etudiant etd =Etudiant();
    SuperModelPostulation ListPostulation =SuperModelPostulation();
      SuperModelOffreStage superModelOffre =SuperModelOffreStage();

    bool circular = true;
    List<postulation> dataPostulation=[]; 
    List<Stage> data=[]; 
    @override
    void initState() {
      fetchDataPostulationList();
    }


  void fetchDataPostulationList() async {
    var response = await networkHandler.get("/postulations/PostulationByToken");
     ListPostulation= SuperModelPostulation.fromJson(response);
    setState(() {
      dataPostulation = ListPostulation.data!;
      fetchDataoffreList();
    });
  }

    void fetchDataoffreList() async {
    var response = await networkHandler.get("/PostulationByTokenOffre");
     superModelOffre= SuperModelOffreStage.fromJson(response);
    setState(() {
      data = superModelOffre.data!;
  
    });
  }


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
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => JobDetail(data[index]));
              },
              child: JobItem(                
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
