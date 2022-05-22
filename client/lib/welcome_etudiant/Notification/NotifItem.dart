// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:pfe/welcome_etudiant/Notification/Notif.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';

import '../../model/offreStageModel.dart';
import '../../model/repondreEtudiant.dart';



class NotifItem extends StatefulWidget {
  final repondreEtudiant notif;
  final Stage offre;
  NotifItem(this.notif,this.offre);

  @override
  State<NotifItem> createState() => _NotifItemState();
}

class _NotifItemState extends State<NotifItem> {




  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  widget.offre.nomOffre as String,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
           
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          widget.notif.message as String,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          widget.notif.objet as String,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(widget.notif.date !=null ? Icons.watch_later : Icons.cancel_presentation_sharp,
                widget.notif.date !=null ?  '${widget.notif.date}' : '' , ),
            //IconText(Icons.access_time_outlined, offre.dateExpiration as String),
          ],
        )
      ]),
    );
  }
}
