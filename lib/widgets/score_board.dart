import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final List<String> teamName;
  final List<int> teamScore;
  final int bid;
  final ScoreMode scoreMode;

  static const double scoreBarUnit = 0.03;
  static const double bidScoreUnit = 0.28;

  ScoreBoard(
      {@required this.teamName,
      @required this.teamScore,
      this.bid,
      this.scoreMode});

  @override
  Widget build(BuildContext context) {
    int bidScore = Score(bid: bid, scoreMode: scoreMode).getScore();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 50.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Team.team1Icon,
                  DisplayScore(score: teamScore[0]),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: <Widget>[
                CustomPaint(
                  painter: AxisPainter(),
                ),
                Container(
                  height: 40.0,
                  // color: Colors.black,
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(6.0, -3.0),
                        child: Container(
                          height: 10.0,
                          width: 10.0,
                          transform: Matrix4.diagonal3Values(
                              teamScore[0] * scoreBarUnit, 1, 1),
                          color: Team.team1Color,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            6.0 + (teamScore[0] + bidScore) * bidScoreUnit,
                            -3.0),
                        // offset: Offset(6.0 + (28), -3.0),
                        child: Container(
                          height: 10.0,
                          width: 2.0,
                          color: Colors.green,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            6.0 + ((teamScore[0] - bidScore)) * bidScoreUnit,
                            -3.0),
                        child: Container(
                          height: 10.0,
                          width: 2.0,
                          color: Colors.red,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(6.0, 8.0),
                        child: Container(
                          height: 10.0,
                          width: 10.0,
                          transform: Matrix4.diagonal3Values(
                              teamScore[1] * scoreBarUnit, 1, 1),
                          color: Team.team2Color,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // bid != null ? Text('$bidScore') : Container(),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 50.0,
              child: Column(
                children: <Widget>[
                  Team.team2Icon,
                  DisplayScore(score: teamScore[1]),
                ],
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
    paint.strokeWidth = 2.5;
    canvas.drawLine(Offset(-150.0, 5.0), Offset(150.0, 5.0), paint);
    for (var i = -150.0; i <= 150; i += 30) {
      canvas.drawLine(Offset(i, 5.0), Offset(i, 10.0), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
