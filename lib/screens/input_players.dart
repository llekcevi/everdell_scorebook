import 'package:everdell_app/screens/complete_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'input_score.dart';
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
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
        home: FutureBuilder(
            future: Hive.openBox("score_records"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text("Everdell Scorebook"),
                    ),
                    body: SafeArea(
                      child: Column(
                        children: [
                          inputPlayersNames(
                              playerScore, username, numberOfPlayers),
                          SizedBox(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        incrementNumberOfPlayers();
                                      });
                                    },
                                    child: const Text("Add a player")),
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
                                    child: const Icon(Icons.arrow_forward)),
                                ElevatedButton(
                                    onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const CompleteResult()))),
                                    child: Text("See results"))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              } else {
                return const Scaffold();
              }
              ;
            }));
  }
}
