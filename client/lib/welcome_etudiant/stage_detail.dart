import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/Postuler/hero_dialog_route.dart';
import 'package:pfe/welcome_etudiant/Postuler/styles.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';

import '../AccueilEtd.dart';
import '../NetworkHandler.dart';
import '../model/Etudiant.dart';
import '../model/offreStageModel.dart';
import '../model/postulation.dart';
import 'Profile/ViewPDF.dart';



class JobDetail extends StatefulWidget {
    final Stage stage;
    JobDetail(this.stage);

  @override
  State<JobDetail> createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
   bool AlertError=false;
   NetworkHandler networkHandler=NetworkHandler();
   postulation postule = postulation();
   TextEditingController objetControl=TextEditingController();
   TextEditingController messageControl=TextEditingController();
   final _formKey = GlobalKey<FormState>();
   Etudiant etd =Etudiant();
   late String url;
   bool circular=true;
    @override
    void initState() {
      fetchData();
      super.initState();
      
    }

  void fetchData() async {
    var response2 = await networkHandler.get("/etudiant/");
    if (!mounted) return;
    setState(() {
      etd = Etudiant.fromJson(response2["data"]);
      url =networkHandler.getCV('${etd.id}');
      circular = false;
    });
  }



  void PostPostulation( String message,String objet) async {
    Map<String, dynamic> data = {
    "objet": objet,
    "message": message,
    };
    var response = await networkHandler.post("/postulations/AddPostulation/${widget.stage.id}",data);
    if(response.statusCode==200){
     print('postulatioin succes');
        setState(() {AlertError=false;});
        _showDialog(context,"Votre demande de postulation est envoyé avec succée.",AlertError);                 
    }else if (response.statusCode==201){
    setState(() {AlertError=false;});
    _showDialog(context,"Vous avez deja postuler à cette offre de stage.",AlertError);                 
    }
    else{
      print('postulatioin failed');
        setState(() {AlertError=true;});
        _showDialog(context,"Votre demande de postulation a échoué.",AlertError);                 
      }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      height: 600,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 5,
              width: 60,
              color: Colors.grey.withOpacity(0.3),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                                NetworkHandler().getImage("${widget.stage.societeId}"),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.stage.username as String,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.stage.nomOffre as String,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconText(Icons.location_city_outlined,
                        widget.stage.localisation as String),
                    IconText(Icons.access_time_filled_outlined,
                        widget.stage.duree as String),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  widget.stage.descriptionOffre as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  height: 45,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    onPressed: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(builder: (context) {
                          return Center(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: Color.fromARGB(255, 67, 177, 183),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: objetControl,
                        decoration: InputDecoration(
                          hintText: 'Objet',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      TextFormField(
                        controller: messageControl,
                        decoration: InputDecoration(
                          hintText: 'Saisir votre Message',
                          border: InputBorder.none,
                        ),
                        cursorColor: Colors.white,
                        maxLines: 10,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                      //button cv
            ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              primary:Color.fromRGBO(100, 80,85,97)  ,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25) ),
            ),
            icon: const Icon(Icons.search,size:32),
            label: const Text(
              'Consulter CV',
              style: TextStyle( color: Colors.white,fontSize: 20)
            ),
            onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(
             builder: (context) => ViewPdf(url),
            ));
            },
            ),

                      FlatButton(
                        onPressed: () {
                        PostPostulation(messageControl.text,objetControl.text);  
                        },
                        child: const Text('Postuler '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
                        }),
                      );
                    },
                    // ignore: prefer_const_constructors
                    child: Hero(
                      tag: _heroAddTodo,
                      child: Text('Postuler'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
_showDialog(BuildContext context,String text,bool Error){
  showDialog(
      context: context,
      builder: (BuildContext context){ 
         return CupertinoAlertDialog(
        title: Column(
          children: <Widget>[
            Text(text),
            
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("OK"),
            onPressed: () {
              if(Error==true) {
                Navigator.of(context).pop();
              } else {
                Navigator.pushNamed(context,'/AccueilEtd');
              } 
            },),
        ],
      );
       });
}


}

const String _heroAddTodo = 'add-todo-hero';


