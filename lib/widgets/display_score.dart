import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayScore extends StatelessWidget {
  final int score;
  final double fontSize;
  DisplayScore({@required this.score, this.fontSize});
  @override
  Widget build(BuildContext context) {
    Color _scoreColor = Colors.black;
    if (score > 0) {
      _scoreColor = Colors.green;
    } else if (score < 0) {
      _scoreColor = Colors.red;
    }
    double _fontSize =
        fontSize ?? Theme.of(context).textTheme.bodyText1.fontSize;
    return ShadowText(
        text: '$score',
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              fontSize: _fontSize,
            ),
        color: _scoreColor);
  }
}
