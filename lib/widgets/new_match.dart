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
  List<String> _defaultTeamName = ["Team 1", "Team 2"];

  @override
  Widget build(BuildContext context) {
    List<Widget> teamName = List.generate(
      2,
      (index) => Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TextField(
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.subtitle1,
              hintText: '${_defaultTeamName[index]}',
            ),
            // style: Theme.of(context).textTheme.subtitle1,
            onChanged: (String value) {
              _defaultTeamName[index] = value;
            },
          ),
        ),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      child: Container(
        height: 280,
        width: 200,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'New Match',
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: teamName,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Container(
                      child: Text(
                        'Best Of',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(5.0),
                      children: <Widget>[
                        Text(
                          '3',
                        ),
                        Text(
                          '5',
                        ),
                        Text(
                          '7',
                        ),
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
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Text(
                      'Scoring',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(5.0),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Avondale',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Original',
                          ),
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
                style: Theme.of(context).textTheme.subtitle2,
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

    List<String> teamName = _defaultTeamName;
    int games = 3 + _gamesSelected.indexOf(true) * 2;
    ScoreMode scoreMode = ScoreMode.values[_scoreModeSelected.indexOf(true)];
    MatchConfig matchConfig = MatchConfig(
        teamName: teamName,
        games: games,
        scoreMode: scoreMode,
        isNewMatch: true,
        uuid: uuid.v4().toString());
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(
              parent: animation, curve: Curves.fastLinearToSlowEaseIn);
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (
          _,
          __,
          ___,
        ) =>
            MatchPage(
          matchConfig: matchConfig,
        ),
      ),
    );
  }
}
