import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Team {
  static const List<Color> teamColors = [Colors.blueAccent, Colors.indigo];
  static const List<Icon> teamIcons = [
    Icon(
      MaterialCommunityIcons.chess_bishop,
      color: Colors.blueAccent,
    ),
    Icon(
      MaterialCommunityIcons.chess_knight,
      color: Colors.indigo,
    )
  ];
  static const Icon crown = Icon(
    MaterialCommunityIcons.crown,
    color: Colors.amber,
  );
}
