import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/state.dart';

class InputPlayersNames extends ConsumerStatefulWidget {
  const InputPlayersNames({
    Key? key,
    required this.numberOfPlayers,
    required this.username,
  }) : super(key: key);
  final int numberOfPlayers;
  final List<TextEditingController> username;

  @override
  ConsumerState<InputPlayersNames> createState() => _InputPlayersNames();
}

class _InputPlayersNames extends ConsumerState<InputPlayersNames> {
  List<bool> nameEntered = [false, false, false, false];
  void checkPlayerName(List names, int index, String name) {
    names[index] == name
        ? nameEntered[index] = true
        : nameEntered[index] = false;
  }

  @override
  Widget build(BuildContext context) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    void addName(int index) =>
        playerScore.updateNames(widget.username[index].text);

    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 32.0),
      itemCount: widget.numberOfPlayers,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white70,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      "Player no. ${index + 1}, enter your name:"),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      textAlign: TextAlign.center,
                      autocorrect: false,
                      controller: widget.username[index],
                      decoration: InputDecoration(
                          suffixIcon:
                              Icon(nameEntered[index] ? Icons.check : null),
                          border: UnderlineInputBorder()),
                      onSubmitted: (String name) {
                        {
                          if (widget.username[index].text.isNotEmpty) {
                            addName(index);
                            setState(() {
                              checkPlayerName(
                                  playerScore.getNames(), index, name);
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(202, 255, 255, 255),
                                      title: Text("Error"),
                                      content: Text(
                                          "Player's name is empty! Please input player's name."),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]);
                                });
                          }
                          print(nameEntered);
                          //print(names);
                        }
                        // print(names);
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
