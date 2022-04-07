import 'package:flutter/material.dart';
import 'package:pfe/welcome_societe/models/offre.dart';
import 'package:pfe/welcome_societe/widgets/offre_item.dart';

class Offre_list extends StatefulWidget {
  const Offre_list({Key? key}) : super(key: key);

  @override
  State<Offre_list> createState() => _Offre_listState();
}

class _Offre_listState extends State<Offre_list> {
  final offreList = offre.generateOffres();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 25,
          ),
          itemBuilder: (context, index) => OffreItem(offreList[index]),
          separatorBuilder: (_, index) => const SizedBox(
                height:20,
              ),
          itemCount: offreList.length),
    );
  }
}