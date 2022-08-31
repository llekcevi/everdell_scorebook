import 'package:everdell_app/screens/scoreboard.dart';
import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'input_scores.dart';
import '../state/state.dart';
import '../widgets/input_players_names.dart';

class InputPlayers extends ConsumerStatefulWidget {
  const InputPlayers({Key? key}) : super(key: key);
  @override
  ConsumerState<InputPlayers> createState() => _Players();
}

class _Players extends ConsumerState<InputPlayers> {
  List<TextEditingController> username =
      List.generate(4, (index) => TextEditingController());

  int numberOfPlayers = 1;

  void incrementNumberOfPlayers() => numberOfPlayers++;

  void updateNumberOfPlayers() =>
      ref.read(playerScoreProvider.notifier).numberOfPlayers = numberOfPlayers;

  @override
  Widget build(BuildContext context) {
    final playerScore = ref.read(playerScoreProvider.notifier);

    return MaterialApp(
        title: "Everdell Scorebook",
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromRGBO(211, 114, 55, 100))),
        home: Container(
          decoration: backgroundImage(),
          child: Container(
            decoration: backgroundGradient(),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text("Everdell Scorebook"),
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          inputPlayersNames(
                              playerScore, username, numberOfPlayers),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  incrementNumberOfPlayers();
                                });
                              },
                              child: const Text("Add a player")),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                updateNumberOfPlayers();
                                print(playerScore.numberOfPlayers);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InputScore()));
                              },
                              child: const Text("Input scores")),
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const CompleteResult()))),
                              child: const Text("See results"))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}