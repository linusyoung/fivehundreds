import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ScoreCard extends StatelessWidget {
  final int bid;
  final int bidTeamIndex;
  final int handIndex;
  final int round;
  final List<int> score;
  final int wonTricks;
  static const List<String> misereText = ['CM', 'OM', 'BM'];

  ScoreCard({
    @required this.bid,
    @required this.round,
    @required this.bidTeamIndex,
    @required this.score,
    @required this.wonTricks,
    @required this.handIndex,
  });

  @override
  Widget build(BuildContext context) {
    String _scoreText = (((bid - bid % 5) / 5).floor() + 6).toString();

    Widget _bidIcon = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Icon(
          Bid.iconList[bid % 5],
          color: Bid.color[bid % 5],
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 12.0,
          ),
          child: Text(
            '$_scoreText',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 110.0,
          child: Column(
            children: <Widget>[
              Text(
                '$round - $handIndex',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    bidTeamIndex == 0 ? Team.team1Icon : Team.team2Icon,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 5.0,
                      ),
                      child: bid <= 24
                          ? _bidIcon
                          : Text(
                              '${misereText[bid - 25]}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                    ),
                    score[bidTeamIndex] > 0 ? Team.crown : Container(),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
                height: 4.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'Won tricks',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text('$wonTricks'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Team.team1Icon,
                    DisplayScore(
                      score: score[0],
                    ),
                    Team.team2Icon,
                    DisplayScore(
                      score: score[1],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
