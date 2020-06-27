import 'package:flutter/material.dart';

class DisplayScore extends StatelessWidget {
  final int score;
  DisplayScore({@required this.score});
  @override
  Widget build(BuildContext context) {
    Color _scoreColor = Colors.black;
    if (score > 0) {
      _scoreColor = Colors.green;
    } else if (score < 0) {
      _scoreColor = Colors.red;
    }

    return Text(
      '$score',
      style: TextStyle(
        color: _scoreColor,
      ),
    );
  }
}
