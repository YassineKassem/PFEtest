import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';
import 'package:pfe/welcome_societe/models/offre.dart';

import '../Screen/CreeOffre.dart';

class OffreItem extends StatelessWidget {
  final offre Offre;
  final bool showTime;
  OffreItem(this.Offre, {this.showTime = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.white),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.1),
                    ),
                    child: Image.asset(Offre.logoUrl),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Offre.company,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const PopUpMen(
                menuList: [
                  PopupMenuItem(
                      child: ListTile(
                        title: Text("Détails"),
                        leading: Icon(
                          CupertinoIcons.doc_append,
                        ),
                      ),
                      value: 0),
                  PopupMenuDivider(),
                  PopupMenuItem(
                      child: ListTile(
                        title: Text("Modifier"),
                        leading: Icon(
                          CupertinoIcons.pencil_ellipsis_rectangle,
                        ),
                      ),
                      value: 1),
                  PopupMenuDivider(),
                  PopupMenuItem(
                      child: ListTile(
                        title: Text(
                          "Supprimer",
                          style: TextStyle(color: Colors.red),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      value: 2),
                ],
              ),
              //Icon(Offre.isMark? Icons.bookmark : Icons.bookmark_outline_outlined,
              //color: Offre.isMark? Theme.of(context).primaryColor: Colors.black,)
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            Offre.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, Offre.location),
              if (showTime) IconText(Icons.access_time_outlined, Offre.time),
            ],
          )
        ],
      ),
    );
  }
}

class PopUpMen extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Widget? icon;
  const PopUpMen({Key? key, required this.menuList, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreeOffre()),
          );
        } else if (result == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreeOffre()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreeOffre()),
          );
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      itemBuilder: ((context) => menuList),
      icon: icon,
    );
  }
}