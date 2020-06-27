import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MatchPage extends StatefulWidget {
  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<bool> _bidSelected = List<bool>.generate(28, (_) => false);
  List<String> _teamName = ['Winwin 1', 'Lose Lose 2'];
  List<int> _teamScore = [0, 0];
  List<bool> _teamSelected = [false, false];
  List<ScoreCard> _handHistory = [];
  static const games = 5;
  List<bool> _matchScore = List<bool>.generate(games + 1, (_) => false);

  int _wonSelected = 0;
  bool _canWin = false;
  bool _canBid = true;
  int _roundPlayed = 0;
  int _handsPlayed = 0;
  String _handResult = 'Best of 5';
  var _wonTricks = List<DropdownMenuItem<int>>.generate(
      11, (i) => DropdownMenuItem<int>(value: i, child: Text('    $i')));
  @override
  Widget build(BuildContext context) {
    int _team = _teamSelected.where((e) => e == true).length;
    int _bid = _bidSelected.where((e) => e == true).length;
    bool _t1Won = _matchScore
                .sublist(0, (games + 1) ~/ 2)
                .where((e) => e == true)
                .length ==
            (games + 1) ~/ 2
        ? true
        : false;
    bool _t2Won =
        _matchScore.sublist((games + 1) ~/ 2).where((e) => e == true).length ==
                (games + 1) ~/ 2
            ? true
            : false;

    _canWin = _team == 1 && _bid == 1 ? true : false;
    List<Widget> _matchScoreWidget = List<Widget>.generate(
        games + 1,
        (index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                color: _matchScore[index] ? Colors.amber : null,
              ),
              height: 10.0,
              width: 20.0,
            ));
    List<Widget> _bidWidget = [
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: TeamSelection(
                  teamName: _teamName[0],
                  selected: _teamSelected[0],
                  teamIndex: 0,
                ),
                onTap: _canBid
                    ? () {
                        _selectTeam(0);
                      }
                    : null,
              ),
            ),
            Expanded(
              child: GestureDetector(
                child: TeamSelection(
                  teamName: _teamName[1],
                  selected: _teamSelected[1],
                  teamIndex: 1,
                ),
                onTap: _canBid
                    ? () {
                        _selectTeam(1);
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 205.0,
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 0,
            childAspectRatio: 2.0,
          ),
          itemCount: 25,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: BidSelection(
                score: index,
                selected: _bidSelected[index],
              ),
              onTap: _canBid
                  ? () {
                      _selectBid(index);
                    }
                  : null,
            );
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  color: _bidSelected[25] ? Theme.of(context).focusColor : null,
                ),
                child: Text(
                  'CM',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              onTap: () {
                _selectBid(25);
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  color: _bidSelected[26] ? Theme.of(context).focusColor : null,
                ),
                child: Text(
                  ' OM',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              onTap: () {
                _selectBid(26);
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 40.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  color: _bidSelected[27] ? Theme.of(context).focusColor : null,
                ),
                child: Text(
                  ' BM',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              onTap: () {
                _selectBid(27);
              },
            ),
          ),
        ],
      )
    ];
    List<Widget> _handResultWidget = [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Tricks won by bidders: ',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<int>(
              value: _wonSelected,
              onChanged: _canWin
                  ? (int newValue) {
                      setState(() {
                        _wonSelected = newValue;
                      });
                    }
                  : null,
              items: _wonTricks,
              style: Theme.of(context).textTheme.headline5,
              hint: Text('Select'),
            ),
          ),
        ],
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text(
                  _canWin ? 'Hand finished' : 'Select team and bid',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: _canWin
                    ? () {
                        _updateResult();
                      }
                    : null,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ];

    Widget _handHistoryWidget = Container(
      height: 120.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _handHistory.length,
          itemBuilder: (BuildContext context, int index) =>
              _handHistory[index]),
    );

    Widget _matchResultWidget = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Icon(
                  MaterialCommunityIcons.chess_bishop,
                  size: 70.0,
                  color: Team.team1Color,
                ),
                _t1Won
                    ? Icon(
                        MaterialCommunityIcons.crown,
                        color: Colors.amber,
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ..._matchScoreWidget,
              ],
            ),
          ),
          Container(
            child: Stack(children: <Widget>[
              Icon(
                MaterialCommunityIcons.chess_knight,
                size: 70.0,
                color: Team.team2Color,
              ),
              _t2Won
                  ? Icon(
                      MaterialCommunityIcons.crown,
                      color: Colors.amber,
                    )
                  : Container(),
            ]),
          )
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('$_handResult'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ScoreBoard(teamName: _teamName, teamScore: _teamScore),
          Divider(
            height: 1.0,
            thickness: 2.0,
          ),
          Column(
            children: <Widget>[
              ..._bidWidget,
              Divider(
                height: 1.0,
                thickness: 2.0,
              ),
              ..._handResultWidget,
              Divider(
                height: 1.0,
                thickness: 2.0,
              ),
              _handHistoryWidget,
              Divider(
                height: 1.0,
                thickness: 2.0,
              ),
              _matchResultWidget,
            ],
          ),
        ],
      ),
    );
  }

  void _selectTeam(int index) {
    setState(() {
      _teamSelected[index] = true;
      _teamSelected[1 - index] = false;
    });
  }

  void _selectBid(int index) {
    setState(() {
      _bidSelected = List<bool>.generate(28, (_) => false);
      _bidSelected[index] = true;
    });
  }

  void _updateResult() {
    int _bid = _bidSelected.indexOf(true);
    int _bidTeam = _teamSelected.indexOf(true);
    Score s = Score(
        bid: _bid,
        bidTeam: _bidTeam,
        wonTricks: _wonSelected,
        scoreMode: ScoreMode.Original);
    List<int> _handScore = s.calculateScore();
    _handScore.asMap().forEach((key, value) {
      _teamScore[key] += value;
    });
    // check win round
    int _mid = (games + 1) ~/ 2;
    var _t1MatchScore = _matchScore.sublist(0, _mid);
    var _t2MatchScore = _matchScore.sublist(_mid);
    setState(() {
      _handsPlayed += 1;
      _handHistory.insert(
          0,
          ScoreCard(
            round: _roundPlayed + 1,
            bid: _bid,
            bidTeamIndex: _bidTeam,
            score: _handScore,
            wonTricks: _wonSelected,
            handIndex: _handsPlayed,
          ));
    });
    if (_teamScore[0] >= 500 || _teamScore[1] <= -500) {
      _t1MatchScore[_t1MatchScore.lastIndexOf(false)] = true;
      _newRound();
    }
    if (_teamScore[1] >= 500 || _teamScore[0] <= -500) {
      _t2MatchScore[_t2MatchScore.indexOf(false)] = true;
      _newRound();
    }
    _matchScore = _t1MatchScore + _t2MatchScore;
    _canBid =
        _matchScore.where((e) => e == true).length > games ~/ 2 ? false : true;
    _resetHand();
  }

  void _newRound() {
    _roundPlayed += 1;
    _handsPlayed = 0;
    _teamScore = [0, 0];
  }

  void _resetHand() {
    _teamSelected = [false, false];
    _bidSelected = List<bool>.generate(28, (_) => false);
    _canWin = false;
  }
}
