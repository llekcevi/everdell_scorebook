import 'package:everdell_app/players.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'main.g.dart';

@HiveType(typeId: 0)
class GameScore {
  @HiveField(0)
  final List _names;
  @HiveField(1)
  final List<List<int>> _scores;
  @HiveField(2)
  final DateTime _timeStamp;

  List getNames() => _names;
  List getScores() => _scores;

  DateTime getDateTime() => _timeStamp;
  GameScore(this._names, this._scores, this._timeStamp);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(GameScoreAdapter());
  runApp(const ProviderScope(child: EverdellScore()));
}

class EverdellScore extends StatelessWidget {
  const EverdellScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Players(),
    );
  }
}

class PlayerScore extends StateNotifier<GameScore> {
  PlayerScore() : super(GameScore([], [], DateTime.now()));

  int numberOfPlayers = 1;

  List getNames() => state._names;

  void updateNames(String name) => state._names.add(name);

  void updateScoreInfo(int index, List<List<TextEditingController>> userInput) {
    List<int> scorePoints = [];
    for (int i = 0; i < 5; i++) {
      scorePoints.add(int.parse(userInput[index][i].text));
    }
    state._scores.add(scorePoints);
  }

  int getScoreSum(List scores, int index) {
    int sum = 0;
    for (int element in scores[index]) {
      sum += element;
    }
    return sum;
  }

  DateTime getTimeStamp() {
    return state._timeStamp;
  }

  List<List<int>> getScores() => state._scores;

  void addScoreToBox(GameScore gameScore) {
    final scoreBox = Hive.box("score_records");
    scoreBox.add(gameScore);
  }
}

final playerScoreProvider =
    StateNotifierProvider<PlayerScore, GameScore>(((ref) => PlayerScore()));
