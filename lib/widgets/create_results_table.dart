import 'package:everdell_app/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResultsTable extends ConsumerWidget {
  const ResultsTable({
    Key? key,
    required this.names,
    required this.scores,
  }) : super(key: key);

  final List names;
  final List scores;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerScore = ref.read(playerScoreProvider.notifier);
    return Container(child: createResultsTable(names, scores, playerScore));
  }
}

Table createResultsTable(List names, List scores, PlayerScore provider) {
  final List<String> firstColumn = [
    "Names",
    "Cards",
    "Tokens",
    "Prosperity bonus",
    "Journey",
    "Events",
    "Total"
  ];

  List<TableRow> rows = [];

  for (int row = 0; row < firstColumn.length; row++) {
    rows.add(TableRow(children: [
      Text(
        textAlign: TextAlign.center,
        firstColumn[row],
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      if (row == 0)
        for (int i = 0; i < names.length; i++)
          Text(
            names[i],
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
      else if (row == firstColumn.length - 1)
        for (int i = 0; i < names.length; i++)
          Text(
            provider.getScoreSum(scores, i).toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
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
