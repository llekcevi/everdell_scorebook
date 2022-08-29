import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Padding scoreElement(String scoreLabel, int i, int index,
    List<List<TextEditingController>> controllers) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          scoreLabel,
        ),
        SizedBox(
          width: 50,
          child: TextField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9]"))
            ],
            controller: controllers[index][i],
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
