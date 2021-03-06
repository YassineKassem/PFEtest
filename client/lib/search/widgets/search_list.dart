import 'package:flutter/material.dart';

import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';

import '../../NetworkHandler.dart';

import '../../model/SuperModelOffreStage.dart';
import '../../model/offreStageModel.dart';
import '../../welcome_etudiant/stage_detail.dart';



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
    late List<String> _dynamicChips = [];
    @override
    void initState() {
      fetchData();
    }

    fetchDataSearch(String S)async{
    var response2 = await networkHandler.get("/offreStage/search1/$S");
    
    superModelOffre2= SuperModelOffreStage.fromJson(response2);
    if (!mounted) return;
    setState(() {
      dataSearch = superModelOffre2.data!;
    });
  }


    void fetchData() async {
    var response = await networkHandler.get("/offreStage/getAllOffre");
    superModelOffre= SuperModelOffreStage.fromJson(response);
    if (!mounted) return;
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
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  
                  controller : controlSearch,
                  onEditingComplete:(){
                    _dynamicChips.add(controlSearch.text);
                  },
                  onChanged: (value)async{
                    if(!value.isEmpty)
                    {
                      if (!mounted) return;
                      setState(() {
                      Nodata="";
                      Search=value;
                                 
                    });

                    await fetchDataSearch(Search);
                    if(dataSearch.length==0)
                    {
                    if (!mounted) return;
                    setState(() {
                      Nodata="Aucun resultat trouver";
                    });
                    }else{
                      if (!mounted) return;
                      setState(() {
                      Nodata="";
                    });
                    }
                    }
                    else{
                      fetchData();
                    if (!mounted) return;
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
          dynamicChips(),
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

  changevalue(String v){
    
    for(int i=0;i<_dynamicChips.length;i++)
    {
    v+=_dynamicChips[i]+" ";
    }
    return  v;
  }

  dynamicChips() {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: List<Widget>.generate(_dynamicChips.length, (int index) {
        return Chip(
          label: Text(_dynamicChips[index]),
          onDeleted: () {
            setState(() {
              _dynamicChips.removeAt(index);
            });
          },
        );
      }),
    );
  }

  }
