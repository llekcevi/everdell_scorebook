import 'package:flutter/material.dart';
import '../state/state.dart';
import './score_element_column.dart';
import 'submit_scores_button.dart';

class InputScoreWidget extends StatelessWidget {
  const InputScoreWidget({
    Key? key,
    required this.player,
    required this.controllers,
    required this.state,
    required this.index,
  }) : super(key: key);

  final String player;
  final List<List<TextEditingController>> controllers;
  final PlayerScore state;
  final int index;

  @override
  Widget build(BuildContext context) {
    print("submittedIndex before build: ${state.submittedIndex}");

    return Card(
      color: Colors.white70,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$player, enter your points",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ScoreElementColumn(
              index: index,
              textControllers: controllers,
            ),
            SubmitScoresButton(
                state: state, index: index, controllers: controllers),
          ],
        ),
      ),
    );
  }
}
