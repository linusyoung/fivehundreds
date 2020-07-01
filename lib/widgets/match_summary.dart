import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/pages/pages.dart';
import 'package:fivehundreds/widgets/match_result.dart';
import 'package:flutter/material.dart';

class MatchSummary extends StatefulWidget {
  final List<String> teamName;
  final List<bool> matchScore;
  final int games;
  // final ScoreMode scoreMode;
  final String uuid;
  MatchSummary({
    @required this.teamName,
    @required this.matchScore,
    @required this.games,
    @required this.uuid,
  }) : assert(teamName?.length != 2 || teamName != null,
            'Team name list must be either empty or two values.');

  @override
  _MatchSummaryState createState() => _MatchSummaryState();
}

class _MatchSummaryState extends State<MatchSummary> {
  @override
  Widget build(BuildContext context) {
    int scoreOffset = ((widget.matchScore.length) ~/ 2);

    List<Widget> matchScoreWidget = List.generate(
        widget.matchScore.length,
        (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MatchResult(won: widget.matchScore[index]),
            ));

    bool completed =
        widget.matchScore.first || widget.matchScore.last ? true : false;
    return Card(
      color: Colors.grey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.matchScore.first
                            ? Team.crown
                            : Team.teamIcons.first,
                        Flexible(
                          child: Text('${widget.teamName[0]}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: matchScoreWidget
                        .sublist(0, scoreOffset)
                        .reversed
                        .toList(),
                  ),
                ],
              ),
            ),
            ButtonTheme(
              minWidth: 120.0,
              height: 30.0,
              child: RaisedButton(
                child: Text(
                  completed ? 'Match detail' : 'Continue',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  _viewMatch();
                },
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: matchScoreWidget.sublist(scoreOffset),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.matchScore.last
                            ? Team.crown
                            : Team.teamIcons.last,
                        Flexible(
                          child: Text('${widget.teamName[1]}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
        MaterialPageRoute(
            builder: (BuildContext context) => MatchPage(
                  matchConfig: matchConfig,
                )));
  }
}
