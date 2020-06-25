import 'package:flutter/material.dart';

class TeamSelection extends StatelessWidget {
  final String teamName;
  final bool selected;

  TeamSelection({@required this.teamName, @required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        color: selected ? Theme.of(context).focusColor : null,
      ),
      child: Text(
        teamName,
        style: Theme.of(context).textTheme.headline4,
      ),
    );
    ;
  }
}
