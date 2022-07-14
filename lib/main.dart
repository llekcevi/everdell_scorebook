import 'package:everdell_app/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: EverdellScore()));
}

class EverdellScore extends StatelessWidget {
  const EverdellScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Players(),
    );
  }
}

class Player {
  String name;
  List names;
  List<dynamic> scores;
  List<int> scorePoints;

  Player(this.name, this.names, this.scores, this.scorePoints);
}

class PlayerScore extends StateNotifier<Player> {
  PlayerScore() : super(Player("", [], [], []));

  int getNumberOfPlayers = 1;

  void setName(String name) => state.name = name;
  String getName() => state.name;

  List getNames() => state.names;
  void updateNames(String name) => state.names.add(name);

  void calculateScore(int index, List<List<TextEditingController>> userInput) {
    int score = 0;
    state.scorePoints.clear();
    for (int i = 0; i < 5; i++) {
      state.scorePoints.add(int.parse(userInput[index][i].text));
      score += int.parse(userInput[index][i].text);
    }
    state.scorePoints.add(score);
  }

  List<int> getScorePoints() => state.scorePoints;

  void updateScoreInfo(int index, List scoreList) {
    Map<String, dynamic> scoreInfo = {};

    scoreInfo["name"] = state.names[index];
    scoreInfo["basePointsForCards"] = scoreList[0];
    scoreInfo["pointTokens"] = scoreList[1];
    scoreInfo["prosperityCardBonusPoints"] = scoreList[2];
    scoreInfo["journeyPoints"] = scoreList[3];
    scoreInfo["events"] = scoreList[4];
    scoreInfo["total"] = scoreList[5];

    state.scores.add(scoreInfo);
  }

  void saveDateTime() => state.scores.add(DateTime.now().toString());

  List getScores() => state.scores;
}

final playerScoreProvider =
    StateNotifierProvider<PlayerScore, Player>(((ref) => PlayerScore()));
