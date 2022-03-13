import 'package:flutter/material.dart';
import 'package:pfe/welcome_etudiant/stage.dart';
import 'package:pfe/welcome_etudiant/stage_item.dart';
import 'package:pfe/welcome_etudiant/stage_list.dart';

class SearchList extends StatelessWidget {
  final JobList = Job.generateJobs();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: ListView.separated(
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          itemBuilder: (context, index) => JobItem(
                JobList[index],
                showTime: true,
              ),
          separatorBuilder: (_, index) => SizedBox(
                height: 20,
              ),
          itemCount: JobList.length),
    );
  }
}
