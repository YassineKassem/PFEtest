import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';

import '../NetworkHandler.dart';
import '../model/offreStageModel.dart';


class JobItem extends StatelessWidget {
  final Stage stage;

  
  JobItem(this.stage);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white
      ),
      child: Column(
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
                    backgroundImage:NetworkHandler().getImage("${stage.username}"),
                  ),
                  ),
                  SizedBox(width: 10,),
                  Text(stage.username as String,
                  style:TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    
                  ),
                  )
                ],
              ),
              //Icon(job.isMark ? Icons.bookmark : Icons.book_online_outlined,
              //color: job.isMark ? Theme.of(context).primaryColor : Colors.black,)
            ],
          ),
          SizedBox(height: 15,),
          Text(stage.nomOffre as String,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, stage.localisation as String),
              //IconText(Icons.access_time_outlined, offre.dateExpiration as String),
              

            ],
          )


      ]),
    );
  }
}
