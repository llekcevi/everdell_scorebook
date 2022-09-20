import 'package:everdell_app/screens/scoreboard.dart';
import 'package:everdell_app/screens/input_names.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../theme/background.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(211, 114, 55, 100))),
        home: FutureBuilder(
            future: Hive.openBox("score_records"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return Container(
                    decoration: backgroundImage(),
                    child: Container(
                      decoration: backgroundGradient(),
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
                                              const Scoreboard())),
                                  child: const Text("See scoreboard"))
                            ],
                          ),
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
