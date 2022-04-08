import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:pfe/welcome_societe/Screen/CreeOffre.dart';
import 'package:pfe/welcome_societe/Screen/ConsulterOffre.dart';
import 'package:pfe/welcome_societe/widgets/listStgiaires.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 215, 168, 86),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Espace,\n",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  TextSpan(
                                    text: "Société !",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 200.0,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(30.0),
                        topRight:  Radius.circular(30.0),
                      ),
                      color: Color.fromRGBO(245, 247, 249, 1),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:  EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                          child:  Text(
                            "Mes opérations",
                            style: TextStyle(
                              color: Color.fromRGBO(19, 22, 33, 1),
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7.0),
                        Container(
                          child: Column(children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CreeOffre()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 30, right: 30, left: 30, bottom: 10),
                                height: 120,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: const Color.fromRGBO(0, 10, 56, 1)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: SvgPicture.asset(
                                          "assets/images/write.svg",
                                          width: 70,
                                          height: 90,
                                        )),
                                    const Positioned(
                                      top: 15,
                                      left: 10,
                                      child:  Text(
                                        "Créer mon offre\n de stage",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConsulterOffre()),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 30, right: 30, left: 30, bottom: 10),
                                height: 120,
                                width: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: const Color.fromARGB(255, 127, 60, 106)),
                                child: Stack(
                                  children: [
                                    Transform(
                                        alignment: Alignment.center,
                                        transform: Matrix4.rotationY(math.pi),
                                        child: SvgPicture.asset(
                                          "assets/images/search.svg",
                                          width: 100,
                                          height: 100,
                                        )),
                                    const Positioned(
                                      top: 25,
                                      right: 50,
                                      child: Text(
                                        "Consulter mes\n offres",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 30, right: 30, left: 30, bottom: 10),
                              height: 120,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: const Color.fromRGBO(71, 59, 117, 1)),
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: SvgPicture.asset(
                                        "assets/images/hiring.svg",
                                        width: 70,
                                        height: 90,
                                      )),
                                  const Positioned(
                                    top: 15,
                                    left: 10,
                                    child: Text(
                                      "Consulter les stagiaires\n pour mes stages",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
