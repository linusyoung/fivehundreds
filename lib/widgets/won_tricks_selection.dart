import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:flutter/material.dart';

class WonTricksSelection extends StatelessWidget {
  final bool canWin;
  final bool selected;
  final int wonTrick;

  WonTricksSelection({
    @required this.canWin,
    @required this.selected,
    @required this.wonTrick,
  });
  @override
  Widget build(BuildContext context) {
    ThemeConfig.init(context);
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        color: selected
            ? Theme.of(context).highlightColor
            : AppTheme.background[ThemeConfig.theme.index],
      ),
      child: Center(
        child: canWin ? Text('$wonTrick') : Text('-'),
      ),
    );
  }
}
