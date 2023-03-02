import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'score_detail.dart';
import '../state/state.dart';
import '../widgets/display_score_card.dart';

class Scoreboard extends ConsumerStatefulWidget {
  const Scoreboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Scoreboard> createState() => _Scoreboard();
}

class _Scoreboard extends ConsumerState<Scoreboard> {
  bool sortingToggle = false;
  bool switchSortingToggle() => sortingToggle = !sortingToggle;
  int changeSorting(bool sortingToggle, int firstIndex, int secondIndex) =>
      sortingToggle ? firstIndex : secondIndex;

  @override
  Widget build(BuildContext context) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    final scoreBox = Hive.box("score_records");
    final numberOfPlayers = playerScore.numberOfPlayers;

    return Container(
      decoration: backgroundImage(),
      child: Container(
        decoration: backgroundGradient(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: (() {
                Navigator.of(context).popUntil((route) => route.isFirst);
                ref.refresh(playerScoreProvider);
              }),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  child: Row(
                    children: [
                      const Text("Sort"),
                      Icon(sortingToggle
                          ? Icons.arrow_downward
                          : Icons.arrow_upward),
                    ],
                  ),
                  onTap: () {
                    setState(
                      () {
                        switchSortingToggle();
                      },
                    );
                  },
                ),
              )
            ],
            title: const Text("Scoreboard"),
          ),
          body: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: scoreBox.length,
                    itemBuilder: (context, index) {
                      final mostRecentOnTop = scoreBox.length - 1 - index;
                      final sortingIndex =
                          changeSorting(sortingToggle, index, mostRecentOnTop);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ScoreDetail(
                                  score: scoreBox,
                                  index: sortingIndex,
                                );
                              },
                            ),
                          );
                        },
                        child: DisplayScoreCard(
                            index: sortingIndex,
                            scoreBox: scoreBox,
                            numberOfPlayers: numberOfPlayers,
                            playerScore: playerScore),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
