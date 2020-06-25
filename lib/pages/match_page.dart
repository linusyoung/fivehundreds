import 'package:fivehundreds/widgets/card_icon.dart';
import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<bool> _selected = List<bool>.generate(25, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('match'),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: CardIcon(
              score: index,
              selected: _selected[index],
            ),
            onTap: () {
              setState(() {
                _selected = List<bool>.generate(25, (_) => false);
                _selected[index] = true;
                print('$index');
              });
            },
          );
        },
      ),
    );
  }
}
