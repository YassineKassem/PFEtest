import 'package:flutter/material.dart';
import 'package:pfe/welcome_societe/widgets/offre_item.dart';

import '../../NetworkHandler.dart';
import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import 'offreDetailSoc.dart';

class Offre_list extends StatefulWidget {
  const Offre_list({Key? key}) : super(key: key);

  @override
  State<Offre_list> createState() => _Offre_listState();
}

class _Offre_listState extends State<Offre_list> {
    NetworkHandler networkHandler=NetworkHandler();
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();
    bool circular = true;
    List<Stage> offreList=[]; 
    @override
    void initState() {
      fetchData();
    }

    void fetchData() async {
    var response = await networkHandler.get("/offreStage/getOwnOffre");
    superModelOffre= SuperModelOffreStage.fromJson(response);
    setState(() {
      offreList = superModelOffre.data!;
      circular = false;
    });
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),         
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => offreDetailSoc(offreList[index]));
              },
              child: OffreItem(offreList[index])),
          
          separatorBuilder: (_, index) => const SizedBox(
                height:20,
              ),
          itemCount: offreList.length),
    );
  }
}