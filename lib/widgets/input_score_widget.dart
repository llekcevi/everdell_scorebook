import 'package:flutter/material.dart';
import '../state/state.dart';
import './score_element_column.dart';

Card inputScoreWidget(
  PlayerScore playerScore,
  int index,
  List<List<TextEditingController>> controllers,
) {
  String player = playerScore.getNames()[index].toString();

  return Card(
    color: Colors.white70,
    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$player, enter your points",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          scoreElementColumn(index, controllers),
          ElevatedButton(
              onPressed: () {
                playerScore.updateScoreInfo(index, controllers);
                print("getScores(list): ${playerScore.getScores()}");

                print("Enter scores in order");
              },
              child: const Text("Submit")),
        ],
      ),
    ),
  );
}
