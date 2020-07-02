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
          color: teamIndex == 0 ? Team.teamColors.first : Team.teamColors.last,
          width: 2.0,
        ),
        color: selected ? Theme.of(context).highlightColor : null,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          teamIndex == 0 ? Team.teamIcons.first : Team.teamIcons.last,
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Transform.translate(
                offset: Offset(-8.0, -1.0),
                child: Center(
                  child: Text(
                    teamName,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
