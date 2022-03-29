import 'package:flutter/material.dart';

import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';

import '../../NetworkHandler.dart';

import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import '../../stage_detail.dart';



  class SearchList extends StatefulWidget {
    const SearchList({ Key? key }) : super(key: key);
  
    @override
    State<SearchList> createState() => _SearchListState();
  }
  
  class _SearchListState extends State<SearchList> {

    TextEditingController controlSearch=TextEditingController();
    NetworkHandler networkHandler=NetworkHandler();
    SuperModelOffreStage superModelOffre =SuperModelOffreStage();
    SuperModelOffreStage superModelOffre2 =SuperModelOffreStage();
    bool circular = true;
    List<Stage> data=[]; 
    List<Stage> dataSearch=[]; 
    String Search="";
    String Nodata="";
    @override
    void initState() {
      fetchData();
    }

    fetchDataSearch(String S)async{
    var response2 = await networkHandler.get("/offreStage/search1/$S");
    
    superModelOffre2= SuperModelOffreStage.fromJson(response2);
    setState(() {
      dataSearch = superModelOffre2.data!;
    });
  }


    void fetchData() async {
    var response = await networkHandler.get("/offreStage/getAllOffre");
    superModelOffre= SuperModelOffreStage.fromJson(response);
    setState(() {
      data = superModelOffre.data!;
      Nodata="";
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Container(
      margin: EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller : controlSearch,
              onChanged: (value)async{
                if(!value.isEmpty)
                {setState(() {
                  Nodata="";
                  Search=value;
                                   
                });
                await fetchDataSearch(Search);
                if(dataSearch.length==0)
                {
                setState(() {
                  Nodata="Aucun resultat trouver";
                });
                }else{
                  setState(() {
                  Nodata="";
                });
                }
                }
                else{
                  fetchData();
                setState(() {
                  Search="";
                  
                });
                  
                }
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                ),
                contentPadding: EdgeInsets.zero,
                prefixIcon: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('assets/icons/search.png',width: 20,),
                )
              ),
            )
            ),
            SizedBox(width: 10,),
            Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20),

              ),
              child: Image.asset('assets/icons/filter.png'),
            )
        ],
      ),
      
    ),      
            Nodata!=""? Container(
            child: Text(Nodata),
            ):Container(),
        Expanded(
          child: Search==""? Container(
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
    ):
    Container(
      margin: EdgeInsets.only(top: 25),
      child: ListView.separated(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                    itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => JobDetail(dataSearch[index]));
              },
              child: JobItem(                
                dataSearch[index],
            )),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: dataSearch.length),
    )),
    ]);
  }
  }
