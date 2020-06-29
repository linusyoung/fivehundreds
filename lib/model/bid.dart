import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Bid {
  static const List<IconData> iconList = [
    MaterialCommunityIcons.cards_spade,
    MaterialCommunityIcons.cards_club,
    MaterialCommunityIcons.cards_diamond,
    MaterialCommunityIcons.cards_heart,
    MaterialCommunityIcons.cards_outline
  ];
  static const List<Color> color = [
    Colors.black,
    Colors.black,
    Colors.red,
    Colors.red,
    Colors.red
  ];

  Icon getBidIcon(int bid) {
    return Icon(
      Bid.iconList[bid % 5],
      color: Bid.color[bid % 5],
    );
  }
}
