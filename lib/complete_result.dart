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
                  displayScore(scoreBox, index, numberOfPlayers),
            ),
          ),
          Row(
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

  Widget displayScore(Box<dynamic> scoreBox, int index, int numberOfPlayers) {
    final names = scoreBox.get(index).getNames();
    final scores = scoreBox.get(index).getScores();
    final dateTime = scoreBox.get(index).getDateTime();

    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(children: [
        Text(dateTime),
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: numberOfPlayers,
              itemBuilder: (context, index) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(names[index].toString()),
                      Text(scores[index].toString()),
                    ],
                  )),
        ),
      ]),
    );
  }
}
