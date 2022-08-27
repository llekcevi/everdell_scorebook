import 'package:everdell_app/screens/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'game_score.g.dart';

@HiveType(typeId: 0)
class GameScore {
  @HiveField(0)
  final _names;
  @HiveField(1)
  final List<List<int>> _scores;
  @HiveField(2)
  final DateTime _timeStamp;

  List getNames() => _names;
  List<List<int>> getScores() => _scores;

  DateTime getDateTime() => _timeStamp;
  GameScore(this._names, this._scores, this._timeStamp);
}
