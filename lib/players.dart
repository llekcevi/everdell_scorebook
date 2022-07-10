import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'input_score.dart';

class Players extends ConsumerStatefulWidget {
  const Players({Key? key}) : super(key: key);

  @override
  ConsumerState<Players> createState() => _Players();
}

class _Players extends ConsumerState<Players> {
  List<TextEditingController> username =
      List.generate(4, (index) => TextEditingController());

  int numberOfPlayers = 1;

  void incrementNumberOfPlayers() => numberOfPlayers++;

  void updateNumberOfPlayers() =>
      ref.read(playerScoreProvider.notifier).getNumberOfPlayers =
          numberOfPlayers;

  @override
  Widget build(BuildContext context) {
    final playerScore = ref.read(playerScoreProvider.notifier);

    return MaterialApp(
        title: "Everdell Scorebook",
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
                    padding: const EdgeInsets.only(top: 32.0),
                    itemCount: numberOfPlayers,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("Player no. ${index + 1}, enter your name:"),
                            SizedBox(
                              width: 300,
                              child: TextField(
                                controller: username[index],
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                onSubmitted: (String name) {
                                  {
                                    playerScore.setName(username[index].text);
                                    playerScore
                                        .updateNames(username[index].text);
                                  }
                                  ;
                                  print(playerScore.getName().toString());
                                  print(playerScore.getNames().toString());
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Text(playerScore.getNames().toString()),
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
                            print(playerScore.getNumberOfPlayers);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const InputScore()));
                          },
                          child: const Icon(Icons.arrow_forward))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
