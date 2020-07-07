import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
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
    SizeConfig().init(context);
    Widget _bidIcon = Container(
      width: 30.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Bid().getBidIcon(bid % 5),
          Text(
            '$_scoreText',
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
    return Card(
      color: Theme.of(context).backgroundColor,
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: SizeConfig.isPhone ? 120.0 : 180.0,
          height: SizeConfig.isPhone ? 125.0 : 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Transform.scale(
                scale: SizeConfig.isPhone ? 1 : 1.5,
                child: Text(
                  '$round - $handIndex',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              Transform.scale(
                scale: SizeConfig.isPhone ? 1 : 1.3,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      bidTeamIndex == 0
                          ? Team.teamIcons.first
                          : Team.teamIcons.last,
                      bid <= 24
                          ? _bidIcon
                          : Container(
                              child: Center(
                                child: Text(
                                  '${misereText[bid - 25]}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ),
                      score[bidTeamIndex] > 0 ? Team.crown : Container(),
                    ],
                  ),
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
                child: Transform.scale(
                  scale: SizeConfig.isPhone ? 1 : 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'won tricks',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text('$wonTricks'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Transform.scale(
                        scale: SizeConfig.isPhone ? 1 : 1.3,
                        child: Team.teamIcons.first),
                    DisplayScore(
                      score: score[0],
                      fontSize: SizeConfig.isPhone ? null : 20.0,
                    ),
                    Transform.scale(
                        scale: SizeConfig.isPhone ? 1 : 1.3,
                        child: Team.teamIcons.last),
                    DisplayScore(
                      score: score[1],
                      fontSize: SizeConfig.isPhone ? null : 20.0,
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
