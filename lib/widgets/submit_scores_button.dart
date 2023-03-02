import 'package:flutter/material.dart';
import '../state/state.dart';

class SubmitScoresButton extends StatelessWidget {
  const SubmitScoresButton({
    Key? key,
    required this.state,
    required this.index,
    required this.controllers,
  }) : super(key: key);

  final PlayerScore state;
  final int index;
  final List<List<TextEditingController>> controllers;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        state.submittedIndex == index
            ? state.updateScoreInfo(index, controllers)
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color.fromARGB(202, 255, 255, 255),
                    title: const Text("Error"),
                    content: const Text("Submit player's scores in order"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
        print("getScores(list): ${state.getScores()}");
        print("submittedIndex: ${state.submittedIndex}");
      },
      child: const Text("Submit"),
    );
  }
}
