import 'dart:io' show Platform;
import 'dart:math';

import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../utils.dart/utils.dart';

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
  final String uuid;
  static const double scoreBarUnit = 0.03;
  static const double bidScoreUnit = 0.3;
  static const List<double> teamYOffset = [-1.0, 11.0];
  ScoreBoard(
      {@required this.teamName,
      @required this.teamScore,
      @required this.matchScore,
      @required this.uuid,
      this.teamIndex = -1,
      this.bidScore});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeConfig.init(context);
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
              offset: Offset(15.0, -15.0),
              child: Team.crown,
            ),
          Hero(
            tag: uuid + '-$index',
            child: Icon(
              Team.teamIconsData[index],
              size: 55.0,
              color: Team.teamColors[index],
            ),
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
              themeIndex: ThemeConfig.theme.index,
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
                color: NipponColors.nipponColor138,
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
                color: NipponColors.nipponColor016,
              ),
            ),
          DisplayScore(
            score: teamScore[index],
            fontSize: 18.0,
          ),
        ],
      ),
    );
    List<Widget> teamWidget = List.generate(
      2,
      (index) => Container(
        width: 145.0,
        child: Row(
          children: <Widget>[
            if (index == 0) teamAvatarWidget[index],
            Spacer(
              flex: 2,
            ),
            teamScoreCircleWidget[index],
            Spacer(
              flex: 2,
            ),
            if (index == 1) teamAvatarWidget[index],
          ],
        ),
      ),
    );

    List<Widget> teamWidgetLandscape = List.generate(
      2,
      (index) => Container(
        width: SizeConfig.blockSizeHorizontal * 15.0,
        height: SizeConfig.blockSizeVertical * 20.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Transform.scale(
              scale: 0.9,
              child: Transform.translate(
                  offset: Offset(-20.0, 0.0), child: teamAvatarWidget[index]),
            ),
            teamScoreCircleWidget[index],
          ],
        ),
      ),
    );

    List<Widget> teamMatchScoreWidget = List.generate(
      2,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 4.0,
          height: SizeConfig.blockSizeVertical * 8.0,
          child: Column(
            children: List.generate(
              teamMatchScores[i].length * 2 - 1,
              (index) => index % 2 == 0
                  ? MatchResult(won: teamMatchScores[i][index ~/ 2])
                  : Divider(
                      height: 3.0,
                    ),
            ),
          ),
        ),
      ),
    );

    List<Widget> teamMatchScoreWidgetLandscape = List.generate(
      2,
      (i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              teamMatchScores[i].length * 2 - 1,
              (index) => index % 2 == 0
                  ? MatchResult(won: teamMatchScores[i][index ~/ 2])
                  : VerticalDivider(
                      width: 3.0,
                    ),
            ),
          ),
        ),
      ),
    );

    Widget matchBidScoreWidget = Container(
      width: SizeConfig.blockSizeHorizontal * 15.0,
      height: SizeConfig.blockSizeVertical * 15.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: teamMatchScoreWidget,
          ),
          Transform.translate(
            offset: Offset(0, -20 * SizeConfig.pixelRatio + 55),
            child: ShadowText(
              text: '$bidScore',
              style: Theme.of(context).textTheme.bodyText1,
              color: AppTheme.textColor[ThemeConfig.theme.index],
            ),
          ),
        ],
      ),
    );

    Widget matchBidScoreWidgetLandscape = Container(
      height: SizeConfig.blockSizeVertical * 25.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: [teamMatchScoreWidgetLandscape[0]],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShadowText(
                text: '$bidScore',
                style: Theme.of(context).textTheme.headline6,
                color: AppTheme.textColor[ThemeConfig.theme.index],
              ),
            ],
          ),
          Row(
            children: [teamMatchScoreWidgetLandscape[1]],
          ),
        ],
      ),
    );

    Widget _mobileView = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          teamWidget[0],
          matchBidScoreWidget,
          teamWidget[1],
        ],
      ),
    );
    // print(SizeConfig.screenHeight);
    Widget _landscapeView = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          teamWidgetLandscape[0],
          matchBidScoreWidgetLandscape,
          teamWidgetLandscape[1],
        ],
      ),
    );
    return (Platform.isMacOS ||
            MediaQuery.of(context).orientation == Orientation.landscape)
        ? _landscapeView
        : _mobileView;
  }
}

class ScoreBarPainter extends CustomPainter {
  final int score;
  final Color color;
  final int themeIndex;

  ScoreBarPainter({
    @required this.score,
    @required this.color,
    @required this.themeIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double r1 = 40;
    double r2 = 35.0;
    // canvas color
    Color backgroundColor = AppTheme.canvas[themeIndex];

    // circle
    paint.strokeWidth = 2;
    paint.color = Colors.blueGrey[200];
    canvas.drawCircle(Offset(0.0, 0.0), r1, paint);
    paint.color = backgroundColor;
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
    Paint paintLine = Paint()..color = backgroundColor;
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
    // win color
    Paint paintLine = Paint()..color = NipponColors.nipponColor149;
    paintLine.strokeWidth = 2.0;
    double winAngle = teamScore + bidScore < 500
        ? pi - theda * (teamScore + bidScore) / 100
        : pi;
    double loseAngle = teamScore - bidScore > -500
        ? pi - theda * (teamScore - bidScore) / 100
        : pi;
    canvas.drawLine(Offset((r1) * sin(winAngle), (r1) * cos(winAngle)),
        Offset((r2) * sin(winAngle), (r2) * cos(winAngle)), paintLine);
    // lose color
    paintLine.color = NipponColors.nipponColor016;
    canvas.drawLine(Offset((r1) * sin(loseAngle), (r1) * cos(loseAngle)),
        Offset((r2) * sin(loseAngle), (r2) * cos(loseAngle)), paintLine);
  }

  @override
  bool shouldRepaint(IndicatorPaint oldDelegate) {
    return oldDelegate.bidScore != bidScore;
  }
}
