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
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset('assets/big.jpg').image,
                fit: BoxFit.fitHeight)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: scoreBox.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScoreDetail(
                                      score: scoreBox,
                                      index: index,
                                    )));
                      },
                      child: displayScoreCard(
                          scoreBox, index, numberOfPlayers, playerScore)),
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
    );
  }
}
