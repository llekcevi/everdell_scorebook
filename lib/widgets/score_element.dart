import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreElement extends StatelessWidget {
  const ScoreElement({
    Key? key,
    required this.textController,
    required this.index,
    required this.label,
    required this.controllerIndex,
  }) : super(key: key);

  final List<List<TextEditingController>> textController;
  final int index;
  final int controllerIndex;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          SizedBox(
            width: 50,
            child: TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
              controller: textController[index][controllerIndex],
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.all(5)),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
