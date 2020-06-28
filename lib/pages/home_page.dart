import 'package:fivehundreds/match_data_helper.dart';
import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: Theme.of(context).textTheme.headline4),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: MatchDataHelper.getAllMatch(),
        initialData: [],
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          return snapshot.hasData
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> matchPrefs =
                        snapshot.data.reversed.toList()[index];
                    var json = matchPrefs.values.toList()[0];
                    MatchInfo matchInfo = MatchInfo.fromJson(json);
                    return MatchSummary(
                      completed: matchInfo.completed,
                      teamName: matchInfo.teamName,
                      games: matchInfo.games,
                      matchScore: matchInfo.matchScore,
                    );
                  })
              : Container(
                  child: Center(
                    child: Text('No match data. Start a new one below.'),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewMatch(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _createNewMatch(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewMatch();
        });
  }
}
