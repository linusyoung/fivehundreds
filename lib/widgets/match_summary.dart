import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MatchSummary extends StatelessWidget {
  final int completed;
  final List<String> teamName;
  final int games;
  final List<bool> matchScore;
  MatchSummary(
      {@required this.completed,
      @required this.teamName,
      @required this.games,
      @required this.matchScore})
      : assert(teamName?.length != 2 || teamName != null,
            'Team name list must be either empty or two values.');
  // assert((completed == 1 && wonTeam < 2),
  //     'Won team index must be 0 or 1 when completed == true. $wonTeam $completed');

  @override
  Widget build(BuildContext context) {
    Icon _status = completed == 1
        ? Icon(
            MaterialCommunityIcons.check_bold,
            size: 40.0,
          )
        : Icon(
            MaterialCommunityIcons.cards_playing_outline,
            size: 40.0,
            color: Theme.of(context).primaryColor,
          );
    int scoreOffset = ((matchScore.length) ~/ 2);
    List<Widget> t1MatchScoreWidget = List.generate(
        scoreOffset,
        (index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: matchScore[(scoreOffset - 1) - index]
                    ? Team.team1Color
                    : null,
              ),
              width: 20.0,
              height: 10.0,
            ));
    List<Widget> t2MatchScoreWidget = List.generate(
        (matchScore.length + 1) ~/ 2,
        (index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: matchScore[index + scoreOffset] ? Team.team2Color : null,
              ),
              width: 20.0,
              height: 10.0,
            ));

    return Card(
      color: Colors.grey[350],
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      matchScore.first ? Team.crown : Team.team1Icon,
                      Text('${teamName[0]}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: t1MatchScoreWidget,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('View detail',
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white,
                      )),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      matchScore.last ? Team.crown : Team.team2Icon,
                      Text('${teamName[1]}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: t2MatchScoreWidget,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // ListTile(
    //   title: completed == 1
    //       ? Text(
    //           '${teamName[wonTeam]} Won',
    //           style: Theme.of(context).textTheme.headline6,
    //         )
    //       : Text('No team won yet.',
    //           style: Theme.of(context).textTheme.headline6),
    //   subtitle: Text('BO$games', style: Theme.of(context).textTheme.subtitle1),
    //   trailing: _status,
    // );
  }
}
