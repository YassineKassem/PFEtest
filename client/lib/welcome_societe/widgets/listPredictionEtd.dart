import 'package:flutter/material.dart';
import 'package:pfe/model/recommendation.dart';
import '../../NetworkHandler.dart';
import '../../model/Etudiant.dart';
import '../../model/SuperModelEtudiant.dart';
import '../../model/SuperModelPostulation.dart';
import '../../model/offreStageModel.dart';
import '../../model/postulation.dart';
import '../../search/widgets/searchBarSoc.dart';
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
    TextEditingController nb=TextEditingController();
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
  for(int i=0; i<List.length;i++)
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
                  'Saisir nombre d étudiants à afficher',
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


