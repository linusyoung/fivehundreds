import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DisplayScore extends StatelessWidget {
  final int score;
  final double fontSize;
  DisplayScore({@required this.score, this.fontSize});
  @override
  Widget build(BuildContext context) {
    ThemeConfig.init(context);

    Color _scoreColor = AppTheme.textColor[ThemeConfig.theme.index];
    if (score > 0) {
      _scoreColor = NipponColors.nipponColor149;
    } else if (score < 0) {
      _scoreColor = NipponColors.nipponColor016;
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
