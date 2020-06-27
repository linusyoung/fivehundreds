import 'package:fivehundreds/model/models.dart';
import 'package:flutter/cupertino.dart';

class MatchConfig {
  final List<String> teamName;
  final int games;
  final ScoreMode scoreMode;

  MatchConfig(
      {@required this.teamName,
      @required this.games,
      @required this.scoreMode});
}
