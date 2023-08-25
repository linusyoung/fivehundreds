enum ScoreMode { Avondale, Original }

class Score {
  final int bidTeam;
  final int bid;
  final int wonTricks;
  final ScoreMode scoreMode;

  List<int> _baseScore = [40, 40];
  static const List<int> scoreStep = [20, 40];
  Score({
    required this.bid,
    required this.scoreMode,
    this.wonTricks = 0,
    this.bidTeam = 0,
  });

  List<int> calculateScore() {
    int bidderScore = getScore();
    // slam
    if (bid <= 10 && wonTricks == 10) {
      bidderScore = 250;
    }
    // misere
    if (bid >= 25 && wonTricks != 0) {
      bidderScore = -bidderScore;
    } else if (bid >= 25 && wonTricks == 0) {
      bidderScore = bidderScore;
    } else {
      bidderScore =
          (bid / 5).floor() + 6 <= wonTricks ? bidderScore : -bidderScore;
    }

    int opposingScore = (10 - wonTricks) * 10;

    return bidTeam == 0
        ? [bidderScore, opposingScore]
        : [opposingScore, bidderScore];
  }

  int getScore() {
    late int bidderScore;

    switch (bid) {
      case 25:
      case 26:
        bidderScore = 250 * (bid - 24);
        break;
      case 27:
        // close misere
        // open misere
        // blind misere
        bidderScore = 1000;
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
