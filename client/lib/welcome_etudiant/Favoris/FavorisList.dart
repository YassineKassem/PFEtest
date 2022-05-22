import 'package:flutter/material.dart';

import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';

import '../../NetworkHandler.dart';

import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import '../stage_detail.dart';
import 'package:pfe/model/Etudiant.dart';



  class FavorisList extends StatefulWidget {
    const FavorisList({ Key? key }) : super(key: key);
  
    @override
    State<FavorisList> createState() => _FavorisListState();
  }
  
  class _FavorisListState extends State<FavorisList> {

    NetworkHandler networkHandler=NetworkHandler();
    Etudiant etd =Etudiant();
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();

    bool circular = true;
    List<Stage> data=[]; 
    @override
    void initState() {
      fetchDataOffreList();
    }


  void fetchDataOffreList() async {
    var response = await networkHandler.get("/favoris/list");
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
    ): Column(
      children: [
                Center(
        child: Text(
          "Liste des favoris est vide",
          textAlign: TextAlign.center,
        ),
      ),
      ],
    );
  }
  }
