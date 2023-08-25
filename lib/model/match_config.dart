import 'package:fivehundreds/model/models.dart';

class MatchConfig {
  final List<String> teamName;
  final int games;
  final ScoreMode scoreMode;
  final String uuid;
  final bool isNewMatch;

  MatchConfig(
      {required this.teamName,
      required this.games,
      required this.scoreMode,
      required this.isNewMatch,
      required this.uuid});
}
