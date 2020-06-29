import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final List<String> teamName;
  final List<int> teamScore;
  final int bid;
  final int teamIndex;
  final ScoreMode scoreMode;
  static const double scoreBarUnit = 0.03;
  static const double bidScoreUnit = 0.3;
  static const List<double> teamYOffset = [-1.0, 11.0];

  ScoreBoard(
      {@required this.teamName,
      @required this.teamScore,
      this.bid,
      this.teamIndex,
      this.scoreMode});

  @override
  Widget build(BuildContext context) {
    int bidScore = 0;
    List<Widget> scoreIndicator = [];
    if (bid != -1 && teamIndex != -1) {
      bidScore = Score(bid: bid, scoreMode: scoreMode).getScore();
      scoreIndicator = List.generate(
        2,
        (index) => Transform.translate(
          offset: Offset(
              4.0 +
                  (teamScore[teamIndex] + (index * 2 - 1) * bidScore) *
                      bidScoreUnit,
              teamYOffset[teamIndex]),
          child: Container(
            height: 10.0,
            width: 2.0,
            color: index == 1 ? Colors.green : Colors.red,
          ),
        ),
      );
    }

    List<Widget> teamWidget = List.generate(
      2,
      (index) => Transform.translate(
        offset: Offset(6.0, teamYOffset[index]),
        child: Container(
          height: 10.0,
          width: 10.0,
          transform:
              Matrix4.diagonal3Values(teamScore[index] * scoreBarUnit, 1, 1),
          color: Team.teamColors[index],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -12.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 50.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Team.teamIcons.first,
                    DisplayScore(score: teamScore[0]),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0.0, 20.0),
                  child: CustomPaint(
                    painter: AxisPainter(),
                  ),
                ),
                Container(
                  height: 40.0,
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      ...teamWidget,
                      if (bidScore != 0) ...scoreIndicator,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$bidScore',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, -12.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: 50.0,
                child: Column(
                  children: <Widget>[
                    Team.teamIcons.last,
                    DisplayScore(score: teamScore[1]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AxisPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    canvas.drawLine(Offset(-150.0, 5.0), Offset(150.0, 5.0), paint);
    for (var i = -150.0; i <= 150; i += 30) {
      canvas.drawLine(Offset(i, 0.0), Offset(i, 10.0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
