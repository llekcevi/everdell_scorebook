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
      child: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("$day.$month.$year"),
                Text("$hour:$minute"),
              ],
            ),
            Container(child: createResultsTable(names, scores))
          ],
        ),
      ),
    );
  }
}
