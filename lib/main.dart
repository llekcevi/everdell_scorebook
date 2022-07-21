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

class GameScore {
  final List _names;
  final List<dynamic> _scores;
  final DateTime _timeStamp;

  GameScore(this._names, this._scores, this._timeStamp);
}

class PlayerScore extends StateNotifier<GameScore> {
  PlayerScore() : super(GameScore([], [], DateTime.now()));

  int numberOfPlayers = 1;

  List getNames() => state._names;

  void updateNames(String name) => state._names.add(name);

  void updateScoreInfo(int index, List<List<TextEditingController>> userInput) {
    Map<String, dynamic> scoreInfo = {};
    List<int> scorePoints = [];
    int score = 0;
    for (int i = 0; i < 5; i++) {
      scorePoints.add(int.parse(userInput[index][i].text));
      score += int.parse(userInput[index][i].text);
    }

    scoreInfo["name"] = state._names[index];
    scoreInfo["basePointsForCards"] = scorePoints[0];
    scoreInfo["pointTokens"] = scorePoints[1];
    scoreInfo["prosperityCardBonusPoints"] = scorePoints[2];
    scoreInfo["journeyPoints"] = scorePoints[3];
    scoreInfo["events"] = scorePoints[4];
    scoreInfo["total"] = score;

    state._scores.add(scoreInfo);
  }

  DateTime getTimeStamp() {
    return state._timeStamp;
  }

  List getScores() => state._scores;

  Map toMap() =>
      {"scores": state._scores, "timeStamp": state._timeStamp.toString()};
}

final playerScoreProvider =
    StateNotifierProvider<PlayerScore, GameScore>(((ref) => PlayerScore()));
