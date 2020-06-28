import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Team {
  static const Color team1Color = Color(0xFF1A237E);
  static const Color team2Color = Colors.indigo;
  static const Icon team1Icon = Icon(
    MaterialCommunityIcons.chess_bishop,
    color: team1Color,
  );
  static const Icon team2Icon = Icon(
    MaterialCommunityIcons.chess_knight,
    color: team2Color,
  );
  static const Icon crown = Icon(
    MaterialCommunityIcons.crown,
    color: Colors.amber,
  );
}
