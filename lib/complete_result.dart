import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CompleteResult extends ConsumerWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final scores = playerScore.getScores();
    final names = playerScore.getNames();
    final date = playerScore.getTimeStamp();

    final scoreBox = Hive.box("score_records");
    final game = scoreBox.get(0) as GameScore;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(game.getNames().toString()),
            Text(game.getScores().toString()),
            Text(game.getDateTime()),
          ],
        ),
      ),
    );
  }
}
