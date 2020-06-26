import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final List<String> teamName;
  final List<int> teamScore;

  static const double scoreBarUnit = 0.03;

  ScoreBoard({@required this.teamName, @required this.teamScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Text(
                '${teamName[0]}',
                style: TextStyle(
                  color: Team.team1Color,
                ),
              ),
              Text(
                '${teamScore[0]}',
                style: TextStyle(
                  color: teamScore[0] > 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
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
                      offset: Offset(4.0, 8.0),
                      child: Container(
                        height: 10.0,
                        width: 10.0,
                        transform: Matrix4.diagonal3Values(
                            teamScore[0] * scoreBarUnit, 1, 1),
                        color: Team.team1Color,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(6.0, -3.0),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Text(
                '${teamName[1]}',
                style: TextStyle(
                  color: Team.team2Color,
                ),
              ),
              Text(
                '${teamScore[1]}',
                style: TextStyle(
                  color: teamScore[1] > 0 ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
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
