import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompleteResult extends ConsumerWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final scoreBox = Hive.box("score_records");
    final numberOfPlayers = playerScore.numberOfPlayers;
    //final game = scoreBox.get(0) as GameScore;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: scoreBox.length,
              itemBuilder: (context, index) =>
                  displayScore(scoreBox, index, numberOfPlayers, playerScore),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () => scoreBox.clear(), child: Text("delete all")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text("back"))
            ],
          )
        ],
      ),
    );
  }

  Widget displayScore(Box<dynamic> scoreBox, int index, int numberOfPlayers,
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
}
