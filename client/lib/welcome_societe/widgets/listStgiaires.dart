import 'package:flutter/material.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import '../../NetworkHandler.dart';
import '../../model/Etudiant.dart';
import '../../model/SuperModelEtudiant.dart';
import '../../model/offreStageModel.dart';
import 'itemStagiaire.dart';

class listStagiaires extends StatefulWidget {
  final Stage stage;
  listStagiaires(this.stage);

  @override
  State<listStagiaires> createState() => _listStagiairesState();
}

class _listStagiairesState extends State<listStagiaires> {

    NetworkHandler networkHandler=NetworkHandler();
    SuperModelEtudiant superModelEtudiant =SuperModelEtudiant();
    bool circular = true;
    List<Etudiant> etudiantList=[]; 
    @override
    void initState() {
      fetchData();
    }

    void fetchData() async {
    var response = await networkHandler.get("/postulations/getEtudiantOffre/${widget.stage.id}");
    superModelEtudiant= SuperModelEtudiant.fromJson(response);
    setState(() {
     etudiantList = superModelEtudiant.data!;
      circular = false;
    });
    
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchAppBar(),
            ListView.separated(
          scrollDirection: Axis.vertical,               
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),         
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                //showModalBottomSheet(
                 //   backgroundColor: Colors.transparent,
                 //   isScrollControlled: true,
                  //  context: context,
                  //  builder: (context) => offreDetailSoc(offreList[index]));
              },
              child: itemStagiaire(etudiantList[index])),
          
          separatorBuilder: (_, index) => const SizedBox(
                height:20,
              ),
          itemCount: etudiantList.length),
          ],
        ),
      ),
    );
  }
}


