import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Players extends StatefulWidget {
  const Players({Key? key}) : super(key: key);

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Everdell Scorebook",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Everdell Scorebook"),
        ),
        body: Text("asd"),
      ),
    );
  }
}
