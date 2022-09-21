import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'scoreboard.dart';
import '../models/game_score.dart';
import '../state/state.dart';
import '../widgets/input_score_widget.dart';
import '../theme/background.dart';
import '../widgets/cancel_icon_button.dart';

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
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(211, 114, 55, 100))),
      home: Container(
        decoration: backgroundImage(),
        child: Container(
          decoration: backgroundGradient(),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text("Everdell Scorebook"),
                actions: [
                  CancelIconButton(
                    ref: ref,
                    buildContext: context,
                    provider: playerScoreProvider,
                  )
                ],
              ),
              body: SafeArea(
                  child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: playerScore.numberOfPlayers,
                        itemBuilder: (BuildContext context, int index) {
                          String player =
                              playerScore.getNames()[index].toString();
                          return InputScoreWidget(
                            player: player,
                            controllers: myControllers,
                            state: playerScore,
                            index: index,
                          );
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final names = playerScore.getNames();
                        final scores = playerScore.getScores();
                        final timeStamp = playerScore.getTimeStamp();
                        final newGameScore =
                            GameScore(names, scores, timeStamp);

                        playerScore.addScoreToBox(newGameScore);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Scoreboard()));
                      },
                      child: const Text("Done"))
                ],
              ))),
        ),
      ),
    );
  }
}
