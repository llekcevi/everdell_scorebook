import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'complete_result.dart';
import 'main.dart';

class InputScore extends ConsumerStatefulWidget {
  const InputScore({Key? key}) : super(key: key);
  @override
  ConsumerState<InputScore> createState() => _InputScoreState();
}

class _InputScoreState extends ConsumerState<InputScore> {
  List<List<TextEditingController>> myControllers = List.generate(
      4, (index) => List.generate(5, (i) => TextEditingController()));

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
              child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: playerScore.numberOfPlayers,
                    itemBuilder: (BuildContext context, int index) {
                      return inputScoreWidget(playerScore, index);
                    }),
              ),
              ElevatedButton(
                  onPressed: () {
                    final names = playerScore.getNames();
                    final scores = playerScore.getScores();
                    final timeStamp = playerScore.getTimeStamp();
                    final newGameScore = GameScore(names, scores, timeStamp);

                    playerScore.addScoreToBox(newGameScore);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CompleteResult()));
                  },
                  child: const Text("See results"))
            ],
          ))),
    );
  }

  Card inputScoreWidget(PlayerScore playerScore, int index) {
    String player = playerScore.getNames()[index].toString();

    return Card(
      color: Colors.white54,
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
            const SizedBox(
              height: 10,
            ),
            scoreElementColumn(index),
            ElevatedButton(
                //change updateScoreInfo()
                onPressed: () {
                  playerScore.updateScoreInfo(index, myControllers);
                  print("getScores(list): ${playerScore.getScores()}");
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }

  Container scoreElementColumn(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
