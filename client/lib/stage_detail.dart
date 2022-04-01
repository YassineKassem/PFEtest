import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';


import 'NetworkHandler.dart';
import 'model/offreStageModel.dart';


class JobDetail extends StatelessWidget {
  final Stage stage;

  
  JobDetail(this.stage);

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
      height: 550,
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
                              backgroundImage:NetworkHandler().getImage("${stage.username}"),
                  ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          stage.username as String,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    /*Row(
                      children: [
                        Icon(
                          job.isMark
                              ? Icons.bookmark
                              : Icons.book_online_rounded,
                          color: job.isMark
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                        Icon(Icons.more_horiz_outlined),
                      ],
                    )*/
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  stage.nomOffre as String,
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
                    IconText(Icons.location_city_outlined, stage.localisation as String),
                    IconText(Icons.access_time_filled_outlined, stage.duree as String),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  stage.descriptionOffre as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /*...job.req
                    .map((e) => Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Row(children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 5,
                              width: 5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: 300,
                              ),
                              child: Text(
                                e,
                                style: TextStyle(
                                  wordSpacing: 2.5,
                                ),
                              ),
                            ),
                          ]),
                        ))
                    .toList(),*/
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
                      onPressed: () {},
                      child: Text('Postuler')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
