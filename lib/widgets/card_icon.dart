import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CardIcon extends StatelessWidget {
  final int score;
  final bool selected;

  static const List<IconData> _iconList = [
    MaterialCommunityIcons.cards_spade,
    MaterialCommunityIcons.cards_club,
    MaterialCommunityIcons.cards_diamond,
    MaterialCommunityIcons.cards_heart,
    MaterialCommunityIcons.cards_outline
  ];
  static const List<Color> _color = [
    Colors.black,
    Colors.black,
    Colors.red,
    Colors.red,
    Colors.red
  ];

  CardIcon({@required this.score, @required this.selected});

  @override
  Widget build(BuildContext context) {
    String _scoreText = (((score - score % 5) / 5).floor() + 6).toString();
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).focusColor : null,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.only(
        left: 15.0,
      ),
      margin: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              _iconList[score % 5],
              color: _color[score % 5],
            ),
          ),
          Text('$_scoreText'),
        ],
      ),
    );
  }
}
