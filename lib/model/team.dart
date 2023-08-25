import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nippon_colors/nippon_colors.dart';

class Team {
  static const List<Color> teamColors = [
    // HANADA
    NipponColors.nipponColor190,
    // FUJINEZUMI
    NipponColors.nipponColor212,
  ];

  static List<IconData> teamIconsData = [
    MdiIcons.ghostOutline,
    MdiIcons.oneUp,
  ];

  static List<Icon> teamIcons = [
    Icon(
      MdiIcons.ghostOutline,
      color: NipponColors.nipponColor190,
    ),
    Icon(
      MdiIcons.oneUp,
      color: NipponColors.nipponColor212,
    )
  ];
  static Icon crown = Icon(
    MdiIcons.crown,
    // UKON
    color: NipponColors.nipponColor110,
  );
}
