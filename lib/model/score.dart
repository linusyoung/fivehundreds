import 'package:flutter/cupertino.dart';

enum ScoreMode { Original, Avondale }

class Score {
  final int bidTeam;
  final int bid;
  final int wonTricks;
  final ScoreMode scoreMode;

  List<int> _baseScore = [40, 40, 20];
  static const List<int> scoreStep = [40, 20];
  Score(
      {@required this.bidTeam,
      @required this.bid,
      @required this.wonTricks,
      @required this.scoreMode});

  List<int> calculateScore() {
    int t1Score;
    switch (bid) {
      case 25:
        // close misere
        t1Score = 250;
        break;
      case 26:
        // open misere
        t1Score = 500;
        break;
      case 27:
        // blind misere
        t1Score = 1000;
        break;
      default:
        if (scoreMode == ScoreMode.Avondale) {
          t1Score =
              _baseScore[scoreMode.index] + bid * scoreStep[scoreMode.index];
        }
        if (scoreMode == ScoreMode.Original) {
          var level = (bid / 5).floor();
          t1Score =
              (((bid % 5) + 1) * (1 + 0.5 * level) * scoreStep[scoreMode.index])
                  .toInt();
        }
    }
    return [t1Score, 100];
  }
}
