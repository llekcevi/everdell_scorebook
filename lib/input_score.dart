import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';

class InputScore extends ConsumerStatefulWidget {
  const InputScore({Key? key}) : super(key: key);
  @override
  ConsumerState<InputScore> createState() => _InputScoreState();
}

var myController = [];

class _InputScoreState extends ConsumerState<InputScore> {
  List<List<TextEditingController>> myControllers = List.generate(
      4, (index) => List.generate(5, (i) => TextEditingController()));

  int displayScore = 0;

  //List<int> userScores = [0, 0];

  List<int> userScoreList = [];
  /*void calculateScore(index) {
    int score = 0;
    for (int i = 0; i < 5; i++) {
      score += int.parse(myController[index][i]);
      userScores[index] = score;
    }
  }
  */

  void updateUserScoreList(index) {
    for (int i = 0; i < 5; i++) {
      userScoreList.add(int.parse(myController[index][i].text));
    }
    //userScoreList.add(userScore);
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
          body: SafeArea(
              child: ListView.builder(
                  itemCount: playerScore.getNumberOfPlayers,
                  itemBuilder: (BuildContext context, int index) {
                    return inputScoreWidget(playerScore, index);
                  }))),
    );
  }

  Column inputScoreWidget(PlayerScore playerScore, int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${playerScore.getNames()[index].toString()}, enter your points",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        scoreElementColumn(index),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              playerScore.calculateScore(index, myControllers);
              print(playerScore.getScorePoints());
              //playerScore.updateScore(userScoreList);
            },
            child: const Text("Submit")),
        Text(
            "Total: $displayScore \n ") //scorelist: $userScoreList ") //\n score: ${playerScore.getScore().toString()}")
      ],
    );
  }

  Container scoreElementColumn(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: [
          scoreElement("Base points for cards:", 0, index),
          scoreElement("Point tokens:", 1, index),
          scoreElement("Prosperity card bonus points:", 2, index),
          scoreElement("Journey points:", 3, index),
          scoreElement("Events:", 4, index)
        ],
      ),
    );
  }

  Padding scoreElement(String scoreLabel, int i, int index) {
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
              controller: myControllers[index][i],
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
