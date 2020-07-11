import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:nippon_colors/nippon_colors.dart';

class MatchResult extends StatelessWidget {
  final bool won;
  MatchResult({@required this.won});
  @override
  Widget build(BuildContext context) {
    ThemeConfig.init(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.textColor[ThemeConfig.theme.index],
          width: 1.0,
        ),
        // HANABA
        color: won ? NipponColors.nipponColor103 : null,
      ),
      width: 20.0,
      height: 10.0,
    );
  }
}
