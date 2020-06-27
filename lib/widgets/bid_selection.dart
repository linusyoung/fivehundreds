import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';

class BidSelection extends StatelessWidget {
  final int score;
  final bool selected;

  BidSelection({@required this.score, @required this.selected});

  @override
  Widget build(BuildContext context) {
    String _scoreText = (((score - score % 5) / 5).floor() + 6).toString();
    return Container(
      width: 40.0,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).highlightColor : null,
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.only(
        left: 10.0,
      ),
      margin: EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Bid.iconList[score % 5],
            color: Bid.color[score % 5],
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
      ),
    );
  }
}
