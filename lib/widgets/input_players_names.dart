import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/state.dart';

class InputPlayersNames extends ConsumerWidget {
  const InputPlayersNames({
    Key? key,
    required this.numberOfPlayers,
    required this.username,
    required this.names,
  }) : super(key: key);

  final int numberOfPlayers;
  final List<TextEditingController> username;
  final String names;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    void addName(int index) => playerScore.updateNames(username[index].text);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 32.0),
      itemCount: numberOfPlayers,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white70,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      "Player no. ${index + 1}, enter your name:"),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      controller: username[index],
                      decoration:
                          const InputDecoration(border: UnderlineInputBorder()),
                      onSubmitted: (String name) {
                        {
                          addName(index);
                        }
                        ;
                        print(names);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
