import 'package:flutter/material.dart';
import '../state/state.dart';
import 'package:hive/hive.dart';

class DisplayScoreCard extends StatelessWidget {
  const DisplayScoreCard({
    Key? key,
    required this.scoreBox,
    required this.numberOfPlayers,
    required this.playerScore,
    required this.index,
  }) : super(key: key);

  final Box scoreBox;
  final int numberOfPlayers;
  final PlayerScore playerScore;
  final int index;

  @override
  Widget build(BuildContext context) {
    {
      final names = scoreBox.get(index).getNames();
      final scores = scoreBox.get(index).getScores();
      final dateTime = scoreBox.get(index).getDateTime();
      final day = dateTime.day;
      final month = dateTime.month;
      final year = dateTime.year;
      final hour = dateTime.hour;
      final minute = dateTime.minute;

      return Card(
        color: Colors.white70,
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        child: SizedBox(
          height: 80,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < names.length; i++)
                  Row(
                    children: [
                      Text(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          "${names[i].toString()}: "),
                      Text(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          playerScore.getScoreSum(scores, i).toString()),
                    ],
                  ),
              ],
            )),
            Text(
                style: const TextStyle(fontWeight: FontWeight.bold),
                "Date: $day.$month.$year. \n Time: $hour:$minute"),
          ]),
        ),
      );
    }
    ;
  }
}
