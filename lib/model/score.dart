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
    int bidderScore;
    int opposingScore;
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
        bidderScore = level + 6 <= wonTricks ? bidderScore : -bidderScore;
    }
    // slam
    if (bid <= 10 && wonTricks == 10) {
      bidderScore = 250;
    }
    opposingScore = (10 - wonTricks) * 10;

    return bidTeam == 0
        ? [bidderScore, opposingScore]
        : [opposingScore, bidderScore];
  }
}
