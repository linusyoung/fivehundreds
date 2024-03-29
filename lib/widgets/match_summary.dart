import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/pages/pages.dart';
import 'package:fivehundreds/widgets/match_result.dart';
import 'package:flutter/material.dart';
import '../utils.dart/utils.dart';

class MatchSummary extends StatefulWidget {
  final List<String> teamName;
  final List<bool> matchScore;
  final int games;
  final String uuid;
  MatchSummary({
    required this.teamName,
    required this.matchScore,
    required this.games,
    required this.uuid,
  }) : assert(teamName.length == 2,
            'Team name list must be either empty or two values.');

  @override
  _MatchSummaryState createState() => _MatchSummaryState();
}

class _MatchSummaryState extends State<MatchSummary> {
  @override
  Widget build(BuildContext context) {
    int scoreOffset = ((widget.matchScore.length) ~/ 2);
    SizeConfig().init(context);
    List<Widget> matchScoreWidget = List.generate(
        widget.matchScore.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MatchResult(won: widget.matchScore[index]),
            ));

    List<Widget> teamWidget = List.generate(
      2,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 2.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: widget.uuid + '-$index',
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Team.teamIcons[index],
              ),
            ),
            Flexible(
              child: Text(
                '${widget.teamName[index]}',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Team.teamColors[index],
                    ),
              ),
            ),
          ],
        ),
      ),
    );

    List<Widget> teamCard = List.generate(
      2,
      (index) => Transform.scale(
        scale: SizeConfig.isPhone ? 1 : 1.5,
        child: Container(
          child: Column(
            children: <Widget>[
              if (index == 1)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: matchScoreWidget.sublist(scoreOffset)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: teamWidget[index],
              ),
              if (index == 0)
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: matchScoreWidget
                        .sublist(0, scoreOffset)
                        .reversed
                        .toList()),
            ],
          ),
        ),
      ),
    );

    bool completed =
        widget.matchScore.first || widget.matchScore.last ? true : false;
    Widget actionButton = Transform.scale(
      scale: SizeConfig.isPhone ? 1 : 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ButtonTheme(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          minWidth: 120.0,
          height: 30.0,
          child: FilledButton(
            child: Text(
              completed ? 'Match detail' : 'Continue',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor),
            onPressed: () {
              _viewMatch();
            },
          ),
        ),
      ),
    );

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).colorScheme.background,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            teamCard.first,
            actionButton,
            teamCard.last,
          ],
        ),
      ),
    );
  }

  void _viewMatch() {
    MatchConfig matchConfig = MatchConfig(
        teamName: widget.teamName,
        games: widget.games,
        scoreMode: ScoreMode.Avondale,
        isNewMatch: false,
        uuid: widget.uuid);

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            MatchPage(
          matchConfig: matchConfig,
        ),
      ),
    );
  }
}
