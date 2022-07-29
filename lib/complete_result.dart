import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteResult extends ConsumerWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final scores = playerScore.getScores();
    final names = playerScore.getNames();
    final date = playerScore.getTimeStamp();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(names.toString()),
            Text(scores.toString()),
            Text(date.toIso8601String()),
          ],
        ),
      ),
    );
  }
}
