import 'dart:convert';

class MatchInfo {
  List<String> teamName;
  List<bool> matchScore;
  List<int> handHistory;
  List<int> teamScore;
  int games;
  int roundPlayed;
  int handsPlayed;
  int completed;
  int scoreModeIndex;

  MatchInfo();

  MatchInfo.fromJson(Map<String, dynamic> json) {
    String _teamName = json['team_name'];
    _teamName = _teamName.substring(1, _teamName.length - 1);
    String _matchScore = json['match_score'];
    _matchScore = _matchScore.substring(1, _matchScore.length - 1);
    String _teamScore = json['team_score'];
    _teamScore = _teamScore.substring(1, _teamScore.length - 1);
    var _handHistory = json['hand_history'];
    if (_handHistory != "[]") {
      String _hand = _handHistory.substring(1, _handHistory.length - 1);
      handHistory = _hand.split(',').map((e) => int.parse(e)).toList();
    } else {
      handHistory = [];
    }

    teamName =
        _teamName.split(',').map((e) => e.substring(1, e.length - 1)).toList();
    matchScore =
        _matchScore.split(',').map((e) => e == 'true' ? true : false).toList();
    teamScore = _teamScore.split(',').map((e) => int.parse(e)).toList();
    games = int.parse(json['games']);
    roundPlayed = int.parse(json['round_played']);
    handsPlayed = int.parse(json['hands_played']);
    completed = int.parse(json['completed']);
    scoreModeIndex = int.parse(json['score_mode_index']);
  }

  Map<String, dynamic> toJson() => {
        'team_name': json.encode(teamName),
        'match_score': json.encode(matchScore),
        'team_score': json.encode(teamScore),
        'games': json.encode(games),
        'round_played': json.encode(roundPlayed),
        'hands_played': json.encode(handsPlayed),
        'completed': json.encode(completed),
        'hand_history': json.encode(handHistory),
        'score_mode_index': json.encode(scoreModeIndex),
      };
}
