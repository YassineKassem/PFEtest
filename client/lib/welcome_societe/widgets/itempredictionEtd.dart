
import 'package:flutter/material.dart';

import '../../NetworkHandler.dart';
import '../../model/Etudiant.dart';
class itempredictionEtd extends StatefulWidget {
  final Etudiant etd;
  final double score;
  itempredictionEtd(this.etd,this.score);

  @override
  State<itempredictionEtd> createState() => _itempredictionEtdState();
}

class _itempredictionEtdState extends State<itempredictionEtd> {
  @override
  Widget build(BuildContext context) {
    return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(40)),
                                    border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    // shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                //: BoxDecoration(
                                  //  shape: BoxShape.circle,
                                   // boxShadow: [
                                   //   BoxShadow(
                                   //     color: Colors.grey.withOpacity(0.5),
                                    //    spreadRadius: 2,
                                    //    blurRadius: 5,
                                    //  ),
                                   // ],
                                 // ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkHandler().getImage("${widget.etd.id}"),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          widget.etd.username as String,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Container(
                                                child: null,
                                              ),
                                      ],
                                    ),
                                    //Text(
                                      //"chat.time",
                                     // style: const TextStyle(
                                      //  fontSize: 11,
                                      //  fontWeight: FontWeight.w300,
                                      //  color: Colors.black54,
                                     // ),
                                   // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.etd.email as String,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: Text("${widget.score}%",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(137, 179, 23, 23),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
  }
}