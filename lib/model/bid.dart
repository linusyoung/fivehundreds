import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nippon_colors/nippon_colors.dart';

class Bid {
  static List<IconData> iconList = [
    MdiIcons.cardsSpade,
    MdiIcons.cardsClub,
    MdiIcons.cardsDiamond,
    MdiIcons.cardsHeart,
    MdiIcons.cards
  ];
  static const List<Color> color = [
    NipponColors.nipponColor250,
    NipponColors.nipponColor250,
    NipponColors.nipponColor016,
    NipponColors.nipponColor016,
    NipponColors.nipponColor250,
  ];

  Icon getBidIcon(int bid) {
    return Icon(
      Bid.iconList[bid % 5],
      color: Bid.color[bid % 5],
      size: 25.0,
    );
  }
}
