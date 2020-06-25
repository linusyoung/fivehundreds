import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HandPage extends StatefulWidget {
  @override
  _HandPageState createState() => _HandPageState();
}

class _HandPageState extends State<HandPage> {
  List<bool> _bidSelected = List<bool>.generate(27, (_) => false);
  List<String> _teamName = ['Team 1', 'Team 2'];
  List<bool> _teamSelected = [false, false];
  String _wonSelected = '0';
  bool _canWin = false;
  String _handResult = 'Ready to play';
  var _wonTricks = List<DropdownMenuItem<String>>.generate(
      11, (i) => DropdownMenuItem<String>(value: '$i', child: Text('    $i')));
  @override
  Widget build(BuildContext context) {
    var _team = _teamSelected.where((e) => e == true).length;
    var _bid = _bidSelected.where((e) => e == true).length;
    if (_team == 1 && _bid == 1) {
      _canWin = true;
    } else {
      _canWin = false;
    }
    print(_wonTricks[1].value);
    return Scaffold(
      appBar: AppBar(
        title: Text('$_handResult'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
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
                    ),
                    onTap: () {
                      _selectTeam(0);
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: TeamSelection(
                      teamName: _teamName[1],
                      selected: _teamSelected[1],
                    ),
                    onTap: () {
                      _selectTeam(1);
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 410.0,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
              itemCount: 25,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: BidSelection(
                    score: index,
                    selected: _bidSelected[index],
                  ),
                  onTap: () {
                    _selectBid(index);
                  },
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
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      color: _bidSelected[25]
                          ? Theme.of(context).focusColor
                          : null,
                    ),
                    child: Text(
                      'Closed Misere',
                      style: Theme.of(context).textTheme.headline5,
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
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      color: _bidSelected[26]
                          ? Theme.of(context).focusColor
                          : null,
                    ),
                    child: Text(
                      'Open Misere',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  onTap: () {
                    _selectBid(26);
                  },
                ),
              ),
            ],
          ),
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
                child: DropdownButton<String>(
                  value: _wonSelected,
                  onChanged: _canWin
                      ? (String newValue) {
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
                      'Hand finished',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _updateResult();
                    },
                    textColor: Colors.white,
                  ),
                ),
              ),
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
      _bidSelected = List<bool>.generate(27, (_) => false);
      _bidSelected[index] = true;
      print('$index');
    });
  }

  void _updateResult() {
    setState(() {
      _handResult = 'Team 1 -500 : +400 Team 2';
    });
  }
}
