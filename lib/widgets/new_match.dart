import 'package:flutter/material.dart';

class NewMatch extends StatefulWidget {
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  List<bool> _isSelected = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 300,
        width: 200,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Team 1'),
                  ),
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Team 2'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Total Rounds'),
              ],
            ),
            ToggleButtons(
              children: <Widget>[
                Text('1'),
                Text('3'),
                Text('5'),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _isSelected[buttonIndex] = true;
                    } else {
                      _isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: _isSelected,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Match styles'),
              ],
            ),
            ToggleButtons(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Perfect'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Avondale'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Original'),
                ),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _isSelected.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _isSelected[buttonIndex] = true;
                    } else {
                      _isSelected[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: _isSelected,
            ),
            RaisedButton(
              child: Text('Create Match'),
              color: Theme.of(context).secondaryHeaderColor,
              onPressed: () => {Navigator.of(context).pop()},
            )
          ],
        ),
      ),
    );
  }
}
