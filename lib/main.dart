import 'package:fivehundreds/widgets/matchinfo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '500 Scorer',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '500 Scorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MatchInfo> placeholder = [
    MatchInfo(),
    MatchInfo(),
    MatchInfo(),
  ];

  void _createNewMatch(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewMatch();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => {},
          ),
        ],
      ),
      body: Center(
        child: ListView.separated(
          itemCount: placeholder.length,
          itemBuilder: (BuildContext context, int index) {
            // TODO: replace with match info
            return placeholder[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 10.0,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewMatch(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

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
