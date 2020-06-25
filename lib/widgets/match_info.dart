import 'package:flutter/material.dart';

class MatchInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Team 1 Won'),
      subtitle: Text('Match score'),
      trailing: Text('date'),
    );
  }
}
