import 'package:flutter/material.dart';



class BodyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Espace",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          Text(
            "Société",
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFe2d7f5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Color(0xff7645c7),
                      ),
                      hintText: 'recherche dans mes offres',
                      hintStyle: TextStyle(
                        color: Color(0xff7645c7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.notifications_none,
                      size: 35,
                      color: Color(0xff7645c7),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height:40),
          Text(
            "Opérations",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      
    );
  }
}