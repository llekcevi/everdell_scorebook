import 'package:everdell_app/screens/scoreboard.dart';
import 'package:everdell_app/screens/input_players.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
        home: FutureBuilder(
            future: Hive.openBox("score_records"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/big.jpg').image,
                            fit: BoxFit.fitHeight)),
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        title: const Text("Everdell Scorebook"),
                      ),
                      body: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InputPlayers())),
                                child: const Text("Add new score")),
                            ElevatedButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CompleteResult())),
                                child: const Text("See scoreboard"))
                          ],
                        ),
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
