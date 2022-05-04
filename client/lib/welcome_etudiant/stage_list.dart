// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/stage_detail.dart';
import 'package:pfe/welcome_etudiant/stage_item.dart';

import '../NetworkHandler.dart';
import '../model/SuperModelOffreStage.dart';
import '../model/offreStageModel.dart';

class JobList extends StatefulWidget {
  const JobList({ Key? key }) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
    NetworkHandler networkHandler=NetworkHandler();
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();
    bool circular = true;
    List<Stage> data=[]; 
    @override
    void initState() {
      fetchData();
    }

    void fetchData() async {
    var response = await networkHandler.get("/offreStage/getAllOffre");
    superModelOffre= SuperModelOffreStage.fromJson(response);
    setState(() {
      data = superModelOffre.data!;
      circular = false;
    });
    
  }
  
    @override
  Widget build(BuildContext context) {
    return Container(
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
              child: JobItem(                
                data[index],
            )),
          separatorBuilder: (_, index) => SizedBox(
                width: 15,
              ),
          itemCount: data.length),
    );
  
  }
}
