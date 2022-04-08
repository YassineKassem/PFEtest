import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/icon_text.dart';
import '../../NetworkHandler.dart';
import '../../model/offreStageModel.dart';
import '../Screen/CreeOffre.dart';


class OffreItem extends StatefulWidget {
  final Stage stage;
  OffreItem(this.stage);

  @override
  State<OffreItem> createState() => _OffreItemState();
}

class _OffreItemState extends State<OffreItem> {

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
              GestureDetector(
                onTap: () => {
                  
                },
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    child: CircleAvatar(
                    radius: 20,
                    backgroundImage:NetworkHandler().getImage("${widget.stage.societeId}"),
                  ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.stage.username as String,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const PopUpMen(
                menuList: [
                  PopupMenuItem(
                      child: ListTile(
                        title: Text("Modifier"),
                        leading: Icon(
                          CupertinoIcons.pencil_ellipsis_rectangle,
                        ),
                      ),
                      value: 0),
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
                      value: 1),
                ],
              ),

            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.stage.nomOffre as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(Icons.location_on_outlined, widget.stage.localisation as String),
              IconText(Icons.access_time_outlined, widget.stage.duree as String),
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