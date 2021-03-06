import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nippon_colors/nippon_colors.dart';

class Bid {
  static const List<IconData> iconList = [
    MaterialCommunityIcons.cards_spade,
    MaterialCommunityIcons.cards_club,
    MaterialCommunityIcons.cards_diamond,
    MaterialCommunityIcons.cards_heart,
    MaterialCommunityIcons.cards
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
