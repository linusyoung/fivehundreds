import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nippon_colors/nippon_colors.dart';

class Team {
  static const List<Color> teamColors = [
    // HANADA
    NipponColors.nipponColor190,
    // FUJINEZUMI
    NipponColors.nipponColor212,
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
      color: NipponColors.nipponColor212,
    )
  ];
  static const Icon crown = Icon(
    MaterialCommunityIcons.crown,
    // UKON
    color: NipponColors.nipponColor110,
  );
}
