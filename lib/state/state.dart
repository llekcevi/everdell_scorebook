import 'package:everdell_app/models/game_score.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlayerScore extends StateNotifier<GameScore> {
  PlayerScore() : super(GameScore([], [], DateTime.now()));

  int submittedIndex = 0;

  int numberOfPlayers = 1;

  List getNames() => state.names;

  void updateNames(String name) => state.names.add(name);

  void updateScoreInfo(int index, List<List<TextEditingController>> userInput) {
    List<int> scorePoints = [];
    for (int i = 0; i < 5; i++) {
      scorePoints.add(int.parse(userInput[index][i].text));
    }
    submittedIndex++;
    state.scores.add(scorePoints);
  }

  int getScoreSum(List scores, int index) {
    int sum = 0;
    for (int element in scores[index]) {
      sum += element;
    }
    return sum;
  }

  DateTime getTimeStamp() {
    return state.timeStamp;
  }

  List<List<int>> getScores() => state.scores;

  void addScoreToBox(GameScore gameScore) {
    final scoreBox = Hive.box("score_records");
    scoreBox.add(gameScore);
  }
}

final playerScoreProvider =
    StateNotifierProvider<PlayerScore, GameScore>(((ref) => PlayerScore()));
