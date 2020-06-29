import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';

class TeamSelection extends StatelessWidget {
  final String teamName;
  final bool selected;
  final int teamIndex;

  TeamSelection(
      {@required this.teamName,
      @required this.selected,
      @required this.teamIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: teamIndex == 0 ? Team.team1Color : Team.team2Color,
          width: 2.0,
        ),
        color: selected ? Theme.of(context).highlightColor : null,
      ),
      child: Row(
        children: <Widget>[
          teamIndex == 0 ? Team.team1Icon : Team.team2Icon,
          Flexible(
            child: Text(
              teamName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
