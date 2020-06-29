import 'package:fivehundreds/match_data_helper.dart';
import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';

class MatchPage extends StatefulWidget {
  final MatchConfig matchConfig;

  MatchPage({this.matchConfig});

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  List<bool> _matchScore = [];
  List<String> _teamName = [];
  List<ScoreCard> _handHistoryCard = [];
  List<int> _handHistory = [];
  List<int> _teamScore = [0, 0];
  List<bool> _teamSelected = [false, false];
  List<bool> _bidSelected = List<bool>.generate(28, (_) => false);
  int _wonSelected = 0;
  int games = 0;
  bool _canWin = false;
  bool _canBid = true;
  int _roundPlayed = 0;
  int _handsPlayed = 0;
  String _titleString = '';
  String _matchUuid = '';
  bool _matchLoaded = false;
  static const misereText = ['CM', 'OM', 'BM'];
  ScoreMode scoreMode;
  var _wonTricks = List<DropdownMenuItem<int>>.generate(
      11, (i) => DropdownMenuItem<int>(value: i, child: Text('    $i')));

  @override
  void initState() {
    games = widget.matchConfig.games;
    _matchScore = List<bool>.generate(games + 1, (_) => false);
    _titleString = 'Best of $games';
    _teamName = widget.matchConfig.teamName;
    _matchUuid = widget.matchConfig.uuid;
    scoreMode = widget.matchConfig.scoreMode;
    if (!widget.matchConfig.isNewMatch) _loadMatch();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _teamCheck = _teamSelected.where((e) => e == true).length;
    int _bidCheck = _bidSelected.where((e) => e == true).length;
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

    _canWin = _teamCheck == 1 && _bidCheck == 1 ? true : false;
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

    List<Widget> _bidMisereWidget = List<Widget>.generate(
      3,
      (index) => Expanded(
        child: GestureDetector(
          child: Container(
            margin: EdgeInsets.all(5.0),
            height: 35.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              color: _bidSelected[index + 25]
                  ? Theme.of(context).highlightColor
                  : null,
            ),
            child: Text(
              misereText[index],
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          onTap: () {
            _selectBid(index + 25);
          },
        ),
      ),
    );
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
          ..._bidMisereWidget,
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
              padding: const EdgeInsets.all(4.0),
              child: RaisedButton(
                child: Text(
                  _canWin ? 'Hand finished' : 'Select team and bid',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
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
      child: _handHistoryCard.length > 0
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _handHistoryCard.length,
              itemBuilder: (BuildContext context, int index) =>
                  _handHistoryCard[index])
          : Center(
              child: Text(
                'No hands played yet.',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
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
                  size: 55.0,
                  color: Team.teamColors.first,
                ),
                _t1Won ? Team.crown : Container(),
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
                size: 55.0,
                color: Team.teamColors.last,
              ),
              _t2Won ? Team.crown : Container(),
            ]),
          )
        ],
      ),
    );

// TODO: remove debug
    _teamScore = [200, -200];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$_titleString',
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ScoreBoard(
              teamName: _teamName,
              teamScore: _teamScore,
              bid: _bidSelected.indexOf(true) ?? -1,
              teamIndex: _teamSelected.indexOf(true) ?? -1,
              scoreMode: scoreMode),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Divider(
              height: 1.0,
              thickness: 2.0,
            ),
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
        scoreMode: scoreMode);
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
      List<int> _hand = [
        _roundPlayed,
        _bid,
        _bidTeam,
        ..._handScore,
        _wonSelected,
        _handsPlayed
      ];
      _hand.forEach((e) => _handHistory.add(e));
      _handHistoryCard.insert(
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
    _canBid = _matchScore.first || _matchScore.last ? false : true;
    _resetHand();
    _saveMatchInfo();
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

  void _saveMatchInfo() {
    MatchInfo matchInfo = MatchInfo();
    matchInfo.teamName = _teamName;
    matchInfo.matchScore = _matchScore;
    matchInfo.teamScore = _teamScore;
    matchInfo.games = games;
    matchInfo.roundPlayed = _roundPlayed;
    matchInfo.handsPlayed = _handsPlayed;
    matchInfo.completed = _canBid ? 0 : 1;
    matchInfo.handHistory = _handHistory;
    matchInfo.scoreModeIndex = scoreMode.index;
    Provider.of<MatchStateNotifier>(context, listen: false)
        .updateMatchState(_matchUuid, matchInfo);
  }

  Future<void> _loadMatch() async {
    var json = await MatchDataHelper.getMatchInfo(_matchUuid);
    if (json != null) {
      MatchInfo matchInfo = MatchInfo.fromJson(json);
      setState(() {
        if (!_matchLoaded) {
          _matchScore = matchInfo.matchScore;
          _teamName = matchInfo.teamName;
          _teamScore = matchInfo.teamScore;
          games = matchInfo.games;
          _roundPlayed = matchInfo.roundPlayed;
          _handsPlayed = matchInfo.handsPlayed;
          scoreMode = ScoreMode.values[matchInfo.scoreModeIndex];
          _canBid = matchInfo.completed == 0 ? true : false;
          // round, bid, bidTeam, team1score, team2score, wonSelected, handsPlayed
          var _hand = [];
          _handHistory = matchInfo.handHistory;
          print(_handHistory);
          _handHistory?.asMap()?.forEach((index, v) {
            _hand.add(v);
            if (index % 7 == 6) {
              _handHistoryCard.insert(
                  0,
                  ScoreCard(
                    round: _hand[0] + 1,
                    bid: _hand[1],
                    bidTeamIndex: _hand[2],
                    score: [_hand[3], _hand[4]],
                    wonTricks: _hand[5],
                    handIndex: _hand[6],
                  ));
              _hand = [];
            }
          });
          _matchLoaded = true;
        }
      });
    }
  }
}
