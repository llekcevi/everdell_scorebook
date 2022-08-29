import 'package:flutter/material.dart';
import '../state/state.dart';

Widget inputPlayersNames(PlayerScore playerScore,
    List<TextEditingController> username, int numberOfPlayers) {
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
                        playerScore.updateNames(username[index].text);
                      }
                      ;
                      print(playerScore.getNames().toString());
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
