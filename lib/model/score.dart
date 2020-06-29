import 'package:flutter/cupertino.dart';

enum ScoreMode { Avondale, Original }

class Score {
  final int bidTeam;
  final int bid;
  final int wonTricks;
  final ScoreMode scoreMode;

  List<int> _baseScore = [40, 40];
  static const List<int> scoreStep = [20, 40];
  Score({
    @required this.bid,
    @required this.scoreMode,
    this.bidTeam,
    this.wonTricks,
  });

  List<int> calculateScore() {
    int bidderScore = getScore();

    bidderScore =
        (bid / 5).floor() + 6 <= wonTricks ? bidderScore : -bidderScore;
    if (bid <= 10 && wonTricks == 10) {
      bidderScore = 250;
    }
    int opposingScore = (10 - wonTricks) * 10;

    return bidTeam == 0
        ? [bidderScore, opposingScore]
        : [opposingScore, bidderScore];
  }

  int getScore() {
    int bidderScore;

    switch (bid) {
      case 25:
      case 26:
        bidderScore = wonTricks == 0 ? 250 * (bid - 24) : -250 * (bid - 24);
        break;
      case 27:
        // close misere
        // open misere
        // blind misere
        bidderScore = wonTricks == 0 ? 1000 : -1000;
        break;
      default:
        int level = (bid / 5).floor();
        if (scoreMode == ScoreMode.Avondale) {
          bidderScore =
              _baseScore[scoreMode.index] + bid * scoreStep[scoreMode.index];
        }
        if (scoreMode == ScoreMode.Original) {
          bidderScore =
              (((bid % 5) + 1) * (1 + 0.5 * level) * scoreStep[scoreMode.index])
                  .toInt();
        }
    }

    return bidderScore;
  }
}
