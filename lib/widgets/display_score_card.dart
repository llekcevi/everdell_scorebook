import 'package:flutter/material.dart';
import '../state/state.dart';
import 'package:hive/hive.dart';

Widget displayScoreCard(Box<dynamic> scoreBox, int index, int numberOfPlayers,
    PlayerScore playerScore) {
  final names = scoreBox.get(index).getNames();
  final scores = scoreBox.get(index).getScores();
  final dateTime = scoreBox.get(index).getDateTime();
  final day = dateTime.day;
  final month = dateTime.month;
  final year = dateTime.year;
  final hour = dateTime.hour;
  final minute = dateTime.minute;

  return Card(
    child: SizedBox(
      height: 70,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text("Date: $day.$month.$year. \n Time: $hour:$minute"),
        SizedBox(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < names.length; i++)
              Row(
                children: [
                  Text("${names[i].toString()}: "),
                  Text(playerScore.getScoreSum(scores, i).toString()),
                ],
              ),
          ],
        )),
      ]),
    ),
  );
}
