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
    return Container(
      width: 30.0,
      height: 30.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        color: selected ? Theme.of(context).highlightColor : null,
      ),
      child: Center(
        child: canWin ? Text('$wonTrick') : Text('-'),
      ),
    );
  }
}
