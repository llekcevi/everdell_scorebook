import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class InputScore extends ConsumerStatefulWidget {
  const InputScore({Key? key}) : super(key: key);
  @override
  ConsumerState<InputScore> createState() => _InputScoreState();
}

class _InputScoreState extends ConsumerState<InputScore> {
  List<TextEditingController> myController =
      List.generate(5, (i) => TextEditingController());
  int displayScore = 0;

  int userScore = 0;

  List<int> userScoreList = [];

  void updateUserScoreList() {
    for (int i = 0; i < 5; i++) {
      userScoreList.add(int.parse(myController[i].text));
    }
    userScoreList.add(userScore);
  }

  void calculateScore() {
    for (int i = 0; i < 5; i++) {
      userScore += int.parse(myController[i].text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final playerScore = ref.read(playerScoreProvider.notifier);

    return MaterialApp(
      title: 'Everdell Scorebook',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Everdell Scorebook"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter your points",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            scoreElementColumn(),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    displayScore == 0 ? calculateScore() : null;
                    displayScore = userScore;
                    updateUserScoreList();
                  });
                  playerScore.updateScore(userScoreList);
                },
                child: const Text("Submit")),
            Text(
                "Total: $displayScore \n scorelist: $userScoreList \n score: ${playerScore.getScore().toString()}")
          ],
        ),
      ),
    );
  }

  Container scoreElementColumn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          scoreElement("Base points for cards:", 0),
          scoreElement("Point tokens:", 1),
          scoreElement("Prosperity card bonus points:", 2),
          scoreElement("Journey points:", 3),
          scoreElement("Events:", 4)
        ],
      ),
    );
  }

  Padding scoreElement(String scoreLabel, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            scoreLabel,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              controller: myController[i],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(5)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
