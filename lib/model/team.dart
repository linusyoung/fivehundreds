import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Team {
  static const List<Color> teamColors = [
    Color.fromRGBO(30, 50, 112, 1),
    // Colors.indigo
    Color.fromRGBO(223, 31, 59, 1),
  ];

  static const List<IconData> teamIconsData = [
    Octicons.hubot,
    Octicons.octoface,
  ];

  static const List<Icon> teamIcons = [
    Icon(
      Octicons.hubot,
      color: Color.fromRGBO(30, 50, 112, 1),
    ),
    Icon(
      Octicons.octoface,
      color: Color.fromRGBO(223, 31, 59, 1),
    )
  ];
  static const Icon crown = Icon(
    MaterialCommunityIcons.crown,
    color: Colors.yellowAccent,
  );
}
