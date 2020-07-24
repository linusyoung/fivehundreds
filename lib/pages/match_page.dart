import 'package:fivehundreds/match_data_helper.dart';
import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart/size_config.dart';

class MatchPage extends StatefulWidget {
  final MatchConfig matchConfig;

  MatchPage({this.matchConfig});

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> with TickerProviderStateMixin {
  List<bool> _matchScore = [];
  List<String> _teamName = [];
  List<ScoreCard> _handHistoryCard = [];
  List<int> _handHistory = [];
  List<int> _teamScore = [0, 0];
  List<bool> _teamSelected = [false, false];
  List<bool> _bidSelected = List<bool>.generate(28, (_) => false);
  int _wonSelected = 0;
  int _bidScore = 0;
  int games = 0;
  // static const double _screenHeightThreshHold = 740.0;
  bool _canWin = false;
  bool _canBid = true;
  int _roundPlayed = 0;
  int _handsPlayed = 0;
  String _titleString = '';
  String _matchUuid = '';
  bool _matchLoaded = false;
  double _handResultWidgetOpacity = 0.2;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  static const misereText = ['CM', 'OM', 'BM'];
  ScoreMode scoreMode;
  List<bool> _wonTricks = List<bool>.generate(11, (_) => false);

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
    SizeConfig().init(context);
    ThemeConfig.init(context);
    Orientation orientation = MediaQuery.of(context).orientation;
    int _teamCheck = _teamSelected.where((e) => e == true).length;
    int _bidCheck = _bidSelected.where((e) => e == true).length;
    _canWin = _teamCheck == 1 && _bidCheck == 1 ? true : false;
    // double _bidButtonRatio = ;
    Widget _divider = Divider(
      height: 1.0,
      thickness: 2.0,
    );
    Widget _vDivider = VerticalDivider(width: 3.0);
    Widget _scoreBoard = ScoreBoard(
      teamName: _teamName,
      teamScore: _teamScore,
      matchScore: _matchScore,
      bidScore: _bidScore,
      uuid: _matchUuid,
      teamIndex: _teamSelected.indexOf(true) ?? -1,
    );
    int _completedCardsInRow = orientation == Orientation.portrait ? 3 : 4;
    Widget _completedHistory = Container(
      height: (SizeConfig.isPhone ? 145.0 : 26 * SizeConfig.blockSizeVertical) *
          (_handHistoryCard.length ~/ _completedCardsInRow +
              (_handHistoryCard.length % _completedCardsInRow == 0 ? 0 : 1)),
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _completedCardsInRow,
          mainAxisSpacing: 0,
          childAspectRatio: 1,
        ),
        itemCount: _handHistoryCard.length,
        itemBuilder: (context, index) {
          return _handHistoryCard.reversed.toList()[index];
        },
      ),
    );

    List<Widget> _bidMisereWidget = List<Widget>.generate(
      3,
      (index) => Expanded(
        child: GestureDetector(
          child: Container(
            margin: EdgeInsets.fromLTRB(5.0, 1, 5.0, 5.0),
            height: orientation == Orientation.landscape
                ? 40
                : SizeConfig.screenWidth / ((SizeConfig.isPhone ? 2 : 2.5) * 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              color: _bidSelected[index + 25]
                  ? Theme.of(context).highlightColor
                  : AppTheme.background[ThemeConfig.theme.index],
              borderRadius: BorderRadius.circular(5.0),
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
    Widget _teamSelectionWidget = Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          2,
          (index) => Expanded(
            child: GestureDetector(
              child: TeamSelection(
                  teamName: _teamName[index],
                  selected: _teamSelected[index],
                  teamIndex: index,
                  disabled: !_canBid),
              onTap: _canBid
                  ? () {
                      _selectTeam(index);
                    }
                  : null,
            ),
          ),
        ).toList(),
      ),
    );
    List<Widget> _bidWidget = [
      _teamSelectionWidget,
      if (!SizeConfig.isPhone && orientation == Orientation.landscape)
        Container(
          height: 50.0,
        ),
      Container(
        height: orientation == Orientation.landscape
            ? SizeConfig.isPhone ? 400.0 / 2 : 300
            : SizeConfig.screenWidth / (SizeConfig.isPhone ? 2 : 2.1),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: SizeConfig.isPhone ? 0 : 10.0,
            childAspectRatio: (SizeConfig.isPhone ? 2 : 2.5),
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
    Widget _roundResultWidget = AnimatedOpacity(
      opacity: _handResultWidgetOpacity,
      duration: Duration(seconds: 1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.isPhone ? 8.0 : 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ...List.generate(
                  11,
                  (index) => GestureDetector(
                    child: WonTricksSelection(
                        canWin: _canWin,
                        selected: _wonTricks[index],
                        wonTrick: index),
                    onTap: _canWin
                        ? () {
                            _selectWonTricks(index);
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      30.0,
                      SizeConfig.isPhone ? 8.0 : 20.0,
                      30.0,
                      SizeConfig.isPhone ? 8.0 : 20.0),
                  child: RaisedButton(
                    child: Text(
                      _canWin ? 'Round finish' : 'Select team and bid',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontSize: SizeConfig.isPhone ? 20.0 : 40.0,
                          ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: _canWin
                        ? () {
                            _updateResult();
                          }
                        : null,
                    textColor: AppTheme.textColor[0],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    List<Widget> _roundsHistoryWidget = [
      Padding(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: orientation == Orientation.landscape
              ? SizeConfig.blockSizeVertical * 35
              : null,
          height: orientation == Orientation.portrait
              ? SizeConfig.isPhone ? 140 : 200
              : null,
          child: _handHistoryCard.length > 0
              ? AnimatedList(
                  key: _listKey,
                  scrollDirection: orientation == Orientation.portrait
                      ? Axis.horizontal
                      : Axis.vertical,
                  initialItemCount: _handHistoryCard.length,
                  itemBuilder: (context, index, animation) {
                    return SizeTransition(
                        axis: Axis.horizontal,
                        sizeFactor: animation,
                        child: _handHistoryCard[index]);
                  })
              : Center(
                  child: Text(
                    'No rounds played yet',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
        ),
      ),
      if (orientation == Orientation.portrait) _divider,
    ];

// landscape
    Widget _playRoundWidgetLandscape = Container(
      width: SizeConfig.isPhone ? 400.0 : 620.0,
      child: ListView(
        children: [
          if (!SizeConfig.isPhone)
            Container(
              height: 10.0,
            ),
          ..._bidWidget,
          if (!SizeConfig.isPhone)
            Container(
              height: 45.0,
            ),
          _roundResultWidget,
        ],
      ),
    );

    Widget _playModeLandscape = Expanded(
      child: Row(
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          _vDivider,
          Expanded(
            child: Center(child: _playRoundWidgetLandscape),
          ),
          _vDivider,
          ..._roundsHistoryWidget,
        ],
      ),
    );

    Widget _viewModeLandscape = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: SizeConfig.blockSizeHorizontal * 3,
          ),
          VerticalDivider(width: 3.0),
          Expanded(
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 80,
              child: Column(
                children: [
                  _teamSelectionWidget,
                  Expanded(child: _completedHistory),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    Widget _displayWidgetLandscape = _matchScore.first || _matchScore.last
        ? _viewModeLandscape
        : _playModeLandscape;

    Widget _landscapeView = Row(
      children: [
        _scoreBoard,
        _displayWidgetLandscape,
      ],
    );
// potrait
    List<Widget> _playRoundWidgetPotrait = [
      ..._bidWidget,
      _divider,
      _roundResultWidget,
      _divider
    ];

    List<Widget> _playModePotrait = [
      ..._playRoundWidgetPotrait,
      ..._roundsHistoryWidget,
    ];

    List<Widget> _viewModePotrait = [
      _teamSelectionWidget,
      _divider,
      _completedHistory,
    ];

    List<Widget> _displayWidgetPotrait = _matchScore.first || _matchScore.last
        ? _viewModePotrait
        : _playModePotrait;

    Widget _potraitView = ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _scoreBoard,
        ),
        _divider,
        ..._displayWidgetPotrait,
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$_titleString',
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
        ),
        body: orientation == Orientation.landscape
            ? _landscapeView
            : _potraitView,
      ),
    );
  }

  void _selectTeam(int index) {
    setState(() {
      _teamSelected[index] = true;
      _teamSelected[1 - index] = false;
      _handResultWidgetOpacity = 1.0;
    });
  }

  void _selectBid(int index) {
    setState(() {
      _bidSelected = List<bool>.generate(28, (i) => i == index ? true : false);
      _bidScore = Score(bid: index, scoreMode: scoreMode).getScore();
      _handResultWidgetOpacity = 1.0;
    });
  }

  void _selectWonTricks(int index) {
    setState(() {
      _wonTricks = List<bool>.generate(11, (i) => i == index ? true : false);
    });
  }

  void _updateResult() {
    int _bid = _bidSelected.indexOf(true);
    int _bidTeam = _teamSelected.indexOf(true);
    _wonSelected = _wonTricks.indexOf(true);
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
      Widget _handWidget = ScoreCard(
        round: _roundPlayed + 1,
        bid: _bid,
        bidTeamIndex: _bidTeam,
        score: _handScore,
        wonTricks: _wonSelected,
        handIndex: _handsPlayed,
      );
      _handHistoryCard.insert(0, _handWidget);
      _listKey.currentState?.insertItem(0);

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
    });
  }

  void _newRound() {
    _roundPlayed += 1;
    _handsPlayed = 0;
    _teamScore = [0, 0];
  }

  void _resetHand() {
    _teamSelected = [false, false];
    _bidSelected = List<bool>.generate(28, (_) => false);
    _wonTricks = List<bool>.generate(11, (_) => false);
    _canWin = false;
    _bidScore = 0;
    _handResultWidgetOpacity = 0.2;
  }

  void _saveMatchInfo() {
    MatchInfo matchInfo = MatchInfo()
      ..teamName = _teamName
      ..matchScore = _matchScore
      ..teamScore = _teamScore
      ..games = games
      ..roundPlayed = _roundPlayed
      ..handsPlayed = _handsPlayed
      ..completed = _canBid ? 0 : 1
      ..handHistory = _handHistory
      ..scoreModeIndex = scoreMode.index;
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
