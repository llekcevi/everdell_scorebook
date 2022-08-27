import 'package:everdell_app/screens/complete_result.dart';
import 'package:everdell_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'input_score.dart';

class Players extends ConsumerStatefulWidget {
  Players({Key? key}) : super(key: key);
  @override
  ConsumerState<Players> createState() => _Players();
}

class _Players extends ConsumerState<Players> {
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
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 32.0),
                              itemCount: numberOfPlayers,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                          "Player no. ${index + 1}, enter your name:"),
                                      SizedBox(
                                        width: 300,
                                        child: TextField(
                                          controller: username[index],
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder()),
                                          onSubmitted: (String name) {
                                            {
                                              playerScore.updateNames(
                                                  username[index].text);
                                            }
                                            ;
                                            print(playerScore
                                                .getNames()
                                                .toString());
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
                return Scaffold();
              }
              ;
            }));
  }
}
