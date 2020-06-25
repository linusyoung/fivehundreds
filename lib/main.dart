import 'package:fivehundreds/pages/pages.dart';
import 'package:fivehundreds/widgets/widgets.dart';
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
    MatchInfo(
      completed: false,
      teamName: ['T1', 'T2'],
      games: 5,
    ),
    MatchInfo(
      completed: true,
      teamName: ['AA', 'CC'],
      games: 7,
      wonTeam: 1,
    ),
    MatchInfo(
      completed: true,
      teamName: ['TT', 'BB'],
      games: 3,
      wonTeam: 0,
    ),
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
              thickness: 2.0,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => _createNewMatch(context),
        onPressed: _showMatchPage,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showMatchPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => HandPage()));
  }
}
