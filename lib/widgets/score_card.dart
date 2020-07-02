import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

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

    Widget _bidIcon = Container(
      width: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Bid().getBidIcon(bid % 5),
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
      ),
    );
    return Card(
      elevation: 10.0,
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
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    bidTeamIndex == 0
                        ? Team.teamIcons.first
                        : Team.teamIcons.last,
                    bid <= 24
                        ? _bidIcon
                        : Expanded(
                            flex: 1,
                            child: Container(
                              // color: Colors.black,
                              child: Center(
                                child: Text(
                                  '${misereText[bid - 25]}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                          ),
                    score[bidTeamIndex] > 0 ? Team.crown : Container(),
                  ],
                ),
              ),
              Divider(
                thickness: 2.0,
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      'won tricks',
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Team.teamIcons.first,
                    DisplayScore(
                      score: score[0],
                    ),
                    Team.teamIcons.last,
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
