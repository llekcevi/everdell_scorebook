import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'complete_result.dart';

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

Widget createResultsTable(List names, List scores) {
  final List<String> firstColumn = [
    "Names",
    "Cards",
    "Tokens",
    "Prosperity bonus",
    "Journey",
    "Events"
  ];

  List<TableRow> rows = [];

  for (int row = 0; row < firstColumn.length; row++) {
    rows.add(TableRow(children: [
      Text(firstColumn[row]),
      if (row == 0)
        for (int i = 0; i < names.length; i++) Text(names[i])
      else
        for (int i = 0; i < names.length; i++)
          Text(scores[i][row - 1].toString())
    ]));
  }
  return Table(children: rows);
}
