import 'package:everdell_app/theme/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'input_scores.dart';
import '../state/state.dart';
import '../widgets/input_players_names.dart';
import '../widgets/cancel_icon_button.dart';

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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        InputPlayersNames(
                          numberOfPlayers: numberOfPlayers,
                          username: username,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                print(playerScore.getNames());
                                numberOfPlayers < 4
                                    ? incrementNumberOfPlayers()
                                    : null;
                              },
                            );
                          },
                          child: const Text("Add another player"),
                        ),
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
                            playerScore.getNames().length != numberOfPlayers
                                ? null
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const InputScore(),
                                    ),
                                  );
                          },
                          child: const Text("Input scores"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
