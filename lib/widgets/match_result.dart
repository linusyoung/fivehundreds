import 'package:flutter/material.dart';

class MatchResult extends StatelessWidget {
  final bool won;
  MatchResult({@required this.won});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[600],
        ),
        color: won ? Colors.amber : null,
      ),
      width: 20.0,
      height: 10.0,
    );
  }
}
