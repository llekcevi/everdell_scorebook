import 'package:everdell_app/state/state.dart';
import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/create_results_table.dart';

class ScoreDetail extends StatelessWidget {
  const ScoreDetail({super.key, required this.score, required this.index});

  final Box<dynamic> score;
  final int index;

  @override
  Widget build(BuildContext context) {
    final names = score.get(index).getNames();
    final scores = score.get(index).getScores();
    final dateTime = score.get(index).getDateTime();
    final day = dateTime.day;
    final month = dateTime.month;
    final year = dateTime.year;
    final hour = dateTime.hour;
    final minute = dateTime.minute;

    return SafeArea(
      child: Container(
        decoration: backgroundImage(),
        child: Container(
          decoration: backgroundGradient(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                color: Colors.white70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Date: $day.$month.$year",
                          style: const TextStyle(fontSize: 17),
                        ),
                        Text(
                          "Time: $hour:$minute",
                          style: const TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.only(
                            top: 15.0, left: 5.0, right: 5.0, bottom: 5.0),
                        child: ResultsTable(
                          names: names,
                          scores: scores,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
