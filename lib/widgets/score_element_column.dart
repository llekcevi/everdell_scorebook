import 'package:flutter/material.dart';
import 'score_element.dart';

Container scoreElementColumn(
  int index,
  List<List<TextEditingController>> controllers,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30.0),
    child: Column(
      children: [
        scoreElement("Base points for cards:", 0, index, controllers),
        scoreElement("Point tokens:", 1, index, controllers),
        scoreElement("Prosperity card bonus points:", 2, index, controllers),
        scoreElement("Journey points:", 3, index, controllers),
        scoreElement("Events:", 4, index, controllers)
      ],
    ),
  );
}
