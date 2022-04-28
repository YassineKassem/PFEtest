import 'package:flutter/material.dart';
import 'package:pfe/model/recommendation.dart';
import 'package:pfe/search/widgets/search_app_bar.dart';
import '../../NetworkHandler.dart';
import '../../model/Etudiant.dart';
import '../../model/SuperModelEtudiant.dart';
import '../../model/SuperModelPostulation.dart';
import '../../model/offreStageModel.dart';
import '../../model/postulation.dart';
import 'StagiaireDetail.dart';
import 'itemStagiaire.dart';
import 'itempredictionEtd.dart';

class listPredictionEtd extends StatefulWidget {
  final Stage stage;
  listPredictionEtd(this.stage);

  @override
  State<listPredictionEtd> createState() => _listPredictionEtdState();
}

class _listPredictionEtdState extends State<listPredictionEtd> {

    NetworkHandler networkHandler=NetworkHandler();
    SuperModelPostulation superModelpostulation =SuperModelPostulation();
    bool circular = true;
    List<postulation> postulationList=[]; 
    List<double> ScoreList=[]; 
    recommendation recomd =new recommendation();
    SuperModelEtudiant superModelEtudiant =SuperModelEtudiant();
    List<Etudiant> etudiantList=[]; 
    @override
    void initState() {
      predict();
    }

    void predict() async {
    var response = await networkHandler.get("/postulations/PredictBestCondidates/${widget.stage.id}");
     if (!mounted) return;
    setState(() {
     fetchDataPostulation();

    });
     
    
  }  
    void fetchDataPostulation() async {
    var response = await networkHandler.get("/postulations/PostulationByOffre/${widget.stage.id}");
    superModelpostulation= SuperModelPostulation.fromJson(response);
    if (!mounted) return;
    setState(() {
     postulationList = superModelpostulation.data!;
     fetchDataRecommendationScore(postulationList);
     
    });
    
  }

  void fetchDataEtd() async {
    var response = await networkHandler.get("/postulations/getEtudiantOffre/${widget.stage.id}");
    superModelEtudiant= SuperModelEtudiant.fromJson(response);
     if (!mounted) return;
    setState(() {
     etudiantList = superModelEtudiant.data!;
     
     circular = false;
 
    });
    
  }


    void fetchDataRecommendationScore( List<postulation> List) async {
  for(int i=0; i<postulationList.length;i++)
  { 
    print(" id ${i} ${List[i].id}");
    var response = await networkHandler.get("/recommendation/listRecommendationByPostulation/${List[i].id}");
      
     setState(() {
      recomd = recommendation.fromJson(response["data"]);
      ScoreList.add(recomd.score as double);
    });
    }
     setState(() {
         fetchDataEtd();
    });
    

  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: circular
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => StagiaireDetail(etudiantList[index],widget.stage));
              },
              child:itempredictionEtd(etudiantList[index],ScoreList[index])),
          
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


