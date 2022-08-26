import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'complete_result.dart';

class ScoreDetail extends StatelessWidget {
  ScoreDetail({super.key, required this.score, required this.index});

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
              children: [
                Text("$day.$month.$year"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
