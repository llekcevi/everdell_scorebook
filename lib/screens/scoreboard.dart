import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'score_detail.dart';
import '../state/state.dart';
import '../widgets/display_score_card.dart';

class CompleteResult extends ConsumerStatefulWidget {
  const CompleteResult({Key? key}) : super(key: key);

  @override
  ConsumerState<CompleteResult> createState() => _CompleteResult();
}

class _CompleteResult extends ConsumerState<CompleteResult> {
  bool sortingToggle = true;
  bool switchSortingToggle() => sortingToggle = !sortingToggle;
  int changeSorting(bool sortingToggle, int firstIndex, int secondIndex) =>
      sortingToggle ? firstIndex : secondIndex;

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: (() {
                      setState(() {
                        switchSortingToggle();
                        print(sortingToggle);
                      });
                    }),
                  ),
                )
              ],
              title: const Text("Everdell Scorebook"),
            ),
            body: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: scoreBox.length,
                      itemBuilder: (context, index) {
                        final mostRecentOnTop = scoreBox.length - 1 - index;

                        return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ScoreDetail(
                                  score: scoreBox,
                                  index: changeSorting(
                                      sortingToggle, index, mostRecentOnTop),
                                );
                              }));
                            },
                            child: DisplayScoreCard(
                                index: changeSorting(
                                    sortingToggle, index, mostRecentOnTop),
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
