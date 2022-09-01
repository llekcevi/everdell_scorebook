import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'score_detail.dart';
import '../state/state.dart';
import '../widgets/display_score_card.dart';

class CompleteResult extends ConsumerWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final scoreBox = Hive.box("score_records");
    final numberOfPlayers = playerScore.numberOfPlayers;

    return SafeArea(
      child: Container(
        decoration: backgroundImage(),
        child: Container(
          decoration: backgroundGradient(),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: scoreBox.length,
                      itemBuilder: (context, index) {
                        final scoreDetailIndex = scoreBox.length - 1 - index;

                        return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ScoreDetail(
                                  score: scoreBox,
                                  index: scoreDetailIndex,
                                );
                              }));
                            },
                            child: DisplayScoreCard(
                                index: scoreDetailIndex,
                                scoreBox: scoreBox,
                                numberOfPlayers: numberOfPlayers,
                                playerScore: playerScore));
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () => scoreBox.clear(),
                          child: Text("delete all")),
                      ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("back"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
