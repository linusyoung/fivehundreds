import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Team {
  static const List<Color> teamColors = [
    // HANADA
    NipponColors.nipponColor190,
    // KARAKURENAI
    NipponColors.nipponColor014,
  ];

  static const List<IconData> teamIconsData = [
    Octicons.hubot,
    Octicons.octoface,
  ];

  static const List<Icon> teamIcons = [
    Icon(
      Octicons.hubot,
      color: NipponColors.nipponColor190,
    ),
    Icon(
      Octicons.octoface,
      color: NipponColors.nipponColor014,
    )
  ];
  static const Icon crown = Icon(
    MaterialCommunityIcons.crown,
    // UKON
    color: NipponColors.nipponColor110,
  );
}
