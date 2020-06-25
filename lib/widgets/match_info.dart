import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MatchInfo extends StatelessWidget {
  final bool completed;
  final List<String> teamName;
  final int wonTeam;
  final int games;
  MatchInfo(
      {@required this.completed,
      @required this.teamName,
      this.wonTeam = 2,
      @required this.games})
      : assert(teamName?.length != 2 || teamName != null,
            'Team name list must be either empty or two values.'),
        assert(
            (completed == true && wonTeam < 2) ||
                (completed == false && wonTeam == 2),
            'Won team index must be 0 or 1 when completed == true. $wonTeam $completed');

  @override
  Widget build(BuildContext context) {
    Icon _status = completed
        ? Icon(
            MaterialCommunityIcons.check_bold,
            size: 40.0,
          )
        : Icon(
            MaterialCommunityIcons.cards_playing_outline,
            size: 40.0,
            color: Theme.of(context).primaryColor,
          );
    return ListTile(
      title: completed
          ? Text('${teamName[wonTeam]} Won')
          : Text('No team won yet.'),
      subtitle: Text('BO$games'),
      trailing: _status,
    );
  }
}
