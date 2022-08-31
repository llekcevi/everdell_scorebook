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
      Text(
        textAlign: TextAlign.center,
        firstColumn[row],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      if (row == 0)
        for (int i = 0; i < names.length; i++)
          Text(
            names[i],
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
      else
        for (int i = 0; i < names.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              scores[i][row - 1].toString(),
              textAlign: TextAlign.center,
            ),
          )
    ]));
  }
  return Table(
      border: const TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.black26, style: BorderStyle.solid),
          verticalInside: BorderSide(
              width: 1, color: Colors.black26, style: BorderStyle.solid)),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: rows);
}
