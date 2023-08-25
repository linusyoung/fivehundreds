import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:flutter/material.dart';

class BidSelection extends StatelessWidget {
  final int score;
  final bool selected;

  BidSelection({required this.score, required this.selected});
  @override
  Widget build(BuildContext context) {
    ThemeConfig.init(context);
    // Color background = ThemeConfig.theme == Brightness.light
    String _scoreText = (((score - score % 5) / 5).floor() + 6).toString();
    return Container(
      width: 40.0,
      height: 40.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? Theme.of(context).highlightColor
            : AppTheme.background[ThemeConfig.theme.index],
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: EdgeInsets.only(
        left: 5.0,
      ),
      margin: EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Transform.scale(
              scale: SizeConfig.isPhone ? 1 : 1.5,
              child: Bid().getBidIcon(score % 5)),
          Transform.scale(
            scale: SizeConfig.isPhone ? 1 : 1.5,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 12.0,
              ),
              child: Text(
                '$_scoreText',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
