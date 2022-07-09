import 'package:everdell_app/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const EverdellScore()));
}

class EverdellScore extends StatelessWidget {
  const EverdellScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Players(),
    );
  }
}

class Player {
  String name;
  List names;
  final Map<String, int> score;
  final List<Map> scores;

  List<int> scorePoints = [0, 0];

  Player(this.name, this.names, this.score, this.scores);
}

class PlayerScore extends StateNotifier<Player> {
  PlayerScore() : super(Player("", [], {}, []));

  int getNumberOfPlayers = 1;

  void setName(String name) => state.name = name;
  String getName() => state.name;

  List getNames() => state.names;
  void updateNames(String name) => state.names.add(name);

  void calculateScore(int index, List<List<TextEditingController>> userInput) {
    int score = 0;
    for (int i = 0; i < 5; i++) {
      score += int.parse(userInput[index][i].text);
      state.scorePoints[index] = score;
    }
  }

  void setScorePoints(int index, int value) => state.scorePoints[index] = value;
  List<int> getScorePoints() => state.scorePoints;

  void updateScore(List scoreList) {
    state.score["basePointsForCards"] = scoreList[0];
    state.score["pointTokens"] = scoreList[1];
    state.score["prosperityCardBonusPoints"] = scoreList[2];
    state.score["journeyPoints"] = scoreList[3];
    state.score["events"] = scoreList[4];
    state.score["total"] = scoreList[5];
  }

  Map getScore() => state.score;
}

final playerScoreProvider =
    StateNotifierProvider<PlayerScore, Player>(((ref) => PlayerScore()));
