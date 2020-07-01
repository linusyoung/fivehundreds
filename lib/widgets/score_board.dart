import 'dart:math';

import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

const double theda = (2 * pi / 5);
const double r1 = 40.0;
const double r2 = 35.0;
const double startAngle = -pi / 2;

class ScoreBoard extends StatelessWidget {
  final List<String> teamName;
  final List<int> teamScore;
  final List<bool> matchScore;
  final int teamIndex;
  final int bidScore;
  static const double scoreBarUnit = 0.03;
  static const double bidScoreUnit = 0.3;
  static const List<double> teamYOffset = [-1.0, 11.0];
  ScoreBoard(
      {@required this.teamName,
      @required this.teamScore,
      @required this.matchScore,
      this.teamIndex = -1,
      this.bidScore});

  @override
  Widget build(BuildContext context) {
    List<bool> _t1Match =
        matchScore.sublist(0, matchScore.length ~/ 2).reversed.toList();
    List<bool> _t2Match = matchScore.sublist(matchScore.length ~/ 2);
    List<List<bool>> teamMatchScores = [_t1Match, _t2Match];
    int selectedTeamScore = teamIndex == -1 ? 0 : teamScore[teamIndex];
    List<Widget> teamAvatarWidget = List.generate(
      2,
      (index) => Stack(
        children: <Widget>[
          if (teamMatchScores[index].last)
            Transform.translate(
              offset: Offset(35.0, -10.0),
              child: Transform.rotate(
                angle: pi / 4,
                child: Team.crown,
              ),
            ),
          Icon(
            Team.teamIconsData[index],
            size: 55.0,
            color: Team.teamColors[index],
          ),
        ],
      ),
    );
    List<Widget> teamScoreCircleWidget = List.generate(
      2,
      (index) => Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            foregroundPainter: ScoreBarPainter(
              score: teamScore[index],
              color: Team.teamColors[index],
            ),
          ),
          if (index == teamIndex)
            CustomPaint(
              foregroundPainter: IndicatorPaint(
                  bidScore: bidScore, teamScore: teamScore[index]),
            ),
          if (index == teamIndex && selectedTeamScore + bidScore >= 500)
            Transform.translate(
              offset: Offset(
                0.0,
                -20.0,
              ),
              child: Icon(
                MaterialCommunityIcons.crown,
                color: Colors.green,
              ),
            ),
          if (index != teamIndex && selectedTeamScore - bidScore <= -500)
            Transform.translate(
              offset: Offset(
                0.0,
                -20.0,
              ),
              child: Icon(
                MaterialCommunityIcons.crown,
                color: Colors.red,
              ),
            ),
          DisplayScore(
            score: teamScore[index],
            fontSize: 20.0,
          ),
        ],
      ),
    );
    List<Widget> teamWidget = List.generate(
      2,
      (index) => Container(
        width: 150.0,
        child: Row(
          children: <Widget>[
            if (index == 0) teamAvatarWidget[index],
            Spacer(
              flex: 1,
            ),
            teamScoreCircleWidget[index],
            Spacer(
              flex: 1,
            ),
            if (index == 1) teamAvatarWidget[index],
          ],
        ),
      ),
    );
    List<Widget> teamMatchScoreWidget = List.generate(
      2,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: 15.0,
          height: 75.0,
          child: Column(
            children: List.generate(
              teamMatchScores[i].length * 2 - 1,
              (index) => index % 2 == 0
                  ? Container(
                      height: 10.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        color: teamMatchScores[i][index ~/ 2]
                            ? Colors.amber
                            : null,
                      ),
                    )
                  : Divider(
                      height: 5.0,
                    ),
            ),
          ),
        ),
      ),
    );
    Widget matchBidScoreWidget = Container(
      width: 70.0,
      height: 75.0,
      child: Row(
        children: <Widget>[
          teamMatchScoreWidget[0],
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ShadowText(
                  text: '$bidScore',
                  style: Theme.of(context).textTheme.bodyText2,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          teamMatchScoreWidget[1],
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8.0,
        14.0,
        8.0,
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          teamWidget[0],
          matchBidScoreWidget,
          teamWidget[1],
        ],
      ),
    );
  }
}

class ScoreBarPainter extends CustomPainter {
  final int score;
  final Color color;

  ScoreBarPainter({@required this.score, @required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double r1 = 40.0;
    double r2 = 35.0;

    // circle
    paint.strokeWidth = 2;
    paint.color = Colors.white;
    canvas.drawCircle(Offset(0.0, 0.0), r1, paint);
    paint.color = Colors.blueGrey[50];
    canvas.drawCircle(Offset(0.0, 0.0), r2, paint);

    // team score
    Paint paintScore = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;
    final rect = Rect.fromCenter(
      center: Offset(0.0, 0.0),
      width: (r1 + r2),
      height: (r1 + r2),
    );
    // canvas.drawRect(rect, paintScore);

    canvas.drawArc(rect, startAngle, theda * score / 100, false, paintScore);

    // ticks
    Paint paintLine = Paint()..color = Colors.blueGrey[50];
    paintLine.strokeWidth = 2.0;
    for (var i = 1; i <= 5; i++) {
      canvas.drawLine(
          Offset(r1 * sin(pi + i * theda), r1 * cos(pi + i * theda)),
          Offset(r2 * sin(pi + i * theda), r2 * cos(pi + i * theda)),
          paintLine);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class IndicatorPaint extends CustomPainter {
  final int bidScore;
  final int teamScore;

  IndicatorPaint({@required this.bidScore, @required this.teamScore});
  @override
  void paint(Canvas canvas, Size size) {
    // ticks
    Paint paintLine = Paint()..color = Colors.green;
    paintLine.strokeWidth = 2.0;
    double winAngle = teamScore + bidScore < 500
        ? pi - theda * (teamScore + bidScore) / 100
        : pi;
    double loseAngle = teamScore - bidScore > -500
        ? pi - theda * (teamScore - bidScore) / 100
        : pi;
    canvas.drawLine(Offset((r1) * sin(winAngle), (r1) * cos(winAngle)),
        Offset((r2) * sin(winAngle), (r2) * cos(winAngle)), paintLine);
    paintLine.color = Colors.red;
    canvas.drawLine(Offset((r1) * sin(loseAngle), (r1) * cos(loseAngle)),
        Offset((r2) * sin(loseAngle), (r2) * cos(loseAngle)), paintLine);
  }

  @override
  bool shouldRepaint(IndicatorPaint oldDelegate) {
    return oldDelegate.bidScore != bidScore;
  }
}
