import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewMatch extends StatefulWidget {
  @override
  _NewMatchState createState() => _NewMatchState();
}

class _NewMatchState extends State<NewMatch> {
  List<bool> _gamesSelected = [true, false, false];
  List<bool> _scoreModeSelected = [true, false];
  String team1Name = "Team 1";
  String team2Name = "Team 2";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: Container(
        height: 250,
        width: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Match Config',
                    style: Theme.of(context).textTheme.subtitle1,
                  )
                ],
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Team 1',
                    ),
                    onChanged: (String value) {
                      team1Name = value;
                    },
                  ),
                ),
                Flexible(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Team 2'),
                    onChanged: (String value) {
                      team2Name = value;
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Best Of',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    height: 30.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('3'),
                        Text('5'),
                        Text('7'),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < _gamesSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              _gamesSelected[buttonIndex] = true;
                            } else {
                              _gamesSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: _gamesSelected,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Scoring',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Container(
                    height: 35.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text('Perfect'),
                        // ),
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
                              buttonIndex < _scoreModeSelected.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              _scoreModeSelected[buttonIndex] = true;
                            } else {
                              _scoreModeSelected[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: _scoreModeSelected,
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Create Match',
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.white,
                    ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: _showMatchPage,
            )
          ],
        ),
      ),
    );
  }

  void _showMatchPage() {
    Navigator.of(context).pop();
    var uuid = Uuid();

    List<String> teamName = [team1Name, team2Name];
    int games = 3 + _gamesSelected.indexOf(true) * 2;
    ScoreMode scoreMode = ScoreMode.values[_scoreModeSelected.indexOf(true)];
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => MatchPage(
                  matchConfig: MatchConfig(
                      teamName: teamName,
                      games: games,
                      scoreMode: scoreMode,
                      uuid: uuid.v4().toString()),
                )));
  }
}
