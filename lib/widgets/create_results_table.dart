import 'package:flutter/material.dart';

Widget createResultsTable(List names, List scores) {
  final List<String> firstColumn = [
    "Names",
    "Cards",
    "Tokens",
    "Prosperity bonus",
    "Journey",
    "Events"
  ];

  List<TableRow> rows = [];

  for (int row = 0; row < firstColumn.length; row++) {
    rows.add(TableRow(children: [
      Text(firstColumn[row]),
      if (row == 0)
        for (int i = 0; i < names.length; i++) Text(names[i])
      else
        for (int i = 0; i < names.length; i++)
          Text(scores[i][row - 1].toString())
    ]));
  }
  return Table(children: rows);
}
