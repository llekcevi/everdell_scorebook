library game_score;

import 'package:hive/hive.dart';

part 'game_score.g.dart';

@HiveType(typeId: 0)
class GameScore {
  @HiveField(0)
  final List names;
  @HiveField(1)
  final List<List<int>> scores;
  @HiveField(2)
  final DateTime timeStamp;

  List getNames() => names;
  List<List<int>> getScores() => scores;

  DateTime getDateTime() => timeStamp;

  GameScore(this.names, this.scores, this.timeStamp);
}
