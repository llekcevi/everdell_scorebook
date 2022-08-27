import 'package:flutter/material.dart';
import '../state/state.dart';

Expanded inputPlayersNames(PlayerScore playerScore,
    List<TextEditingController> username, int numberOfPlayers) {
  return Expanded(
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
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
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
        );
      },
    ),
  );
}
