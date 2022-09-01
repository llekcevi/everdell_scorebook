import 'package:flutter/material.dart';
import 'score_element.dart';

class ScoreElementColumn extends StatelessWidget {
  const ScoreElementColumn(
      {Key? key, required this.index, required this.textControllers})
      : super(key: key);

  final int index;
  final List<List<TextEditingController>> textControllers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          ScoreElement(
            textController: textControllers,
            controllerIndex: 0,
            index: index,
            label: "Base points for cards:",
          ),
          ScoreElement(
            textController: textControllers,
            controllerIndex: 1,
            index: index,
            label: "Point tokens",
          ),
          ScoreElement(
            textController: textControllers,
            controllerIndex: 2,
            index: index,
            label: "Prosperity card bonus points",
          ),
          ScoreElement(
            textController: textControllers,
            controllerIndex: 3,
            index: index,
            label: "Journey points",
          ),
          ScoreElement(
            textController: textControllers,
            controllerIndex: 4,
            index: index,
            label: "Events",
          )
        ],
      ),
    );
  }
}
