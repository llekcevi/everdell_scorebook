import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteResult extends ConsumerWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final score = playerScore.getScores();

    return Scaffold(
        body: Center(
            child: Text(
                "${score[0]["name"]} scored ${score[0]["total"]},   ${score[1]["name"]} scored ${score[1]["total"]} \n")));
  }
}
