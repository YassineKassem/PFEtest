// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pfe/model/Etudiant.dart';
import 'package:pfe/welcome_etudiant/Notification/Notif.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';



class NotifItem extends StatefulWidget {
  final Notif notif;
  NotifItem(this.notif);

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
                  widget.notif.nomSociete as String,
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
          widget.notif.objet as String,
          style: TextStyle(fontWeight: FontWeight.bold),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(Icons.watch_later,
                widget.notif.dateEnvoi as String),
            //IconText(Icons.access_time_outlined, offre.dateExpiration as String),
          ],
        )
      ]),
    );
  }
}
