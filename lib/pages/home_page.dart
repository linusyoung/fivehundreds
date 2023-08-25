import 'package:fivehundreds/match_data_helper.dart';
import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:fivehundreds/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _opacity = 1.0;
  int _cardsInRow = 5;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (Platform.isMacOS) {
      if (SizeConfig.screenWidth >= 540) _cardsInRow = 5;
      if (SizeConfig.screenWidth < 540) _cardsInRow = 3;
      if (SizeConfig.screenWidth < 325) _cardsInRow = 2;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: Theme.of(context).textTheme.headlineMedium),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () => _showScoreInfo(context),
            )
          ],
        ),
        body: AnimatedOpacity(
          opacity: _opacity,
          curve: Curves.easeOutSine,
          duration: Duration(milliseconds: 500),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: MatchDataHelper.getAllMatch(),
            initialData: [],
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    orientation == Orientation.portrait
                                        ? 3
                                        : _cardsInRow,
                                mainAxisSpacing: 0,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> matchPrefs =
                                    snapshot.data!.reversed.toList()[index];
                                var json = matchPrefs.values.toList()[0];
                                MatchInfo matchInfo = MatchInfo.fromJson(json);
                                return MatchSummary(
                                  teamName: matchInfo.teamName,
                                  matchScore: matchInfo.matchScore,
                                  uuid: matchPrefs.keys.toList()[0],
                                  games: matchInfo.games,
                                );
                              });
                        },
                      ),
                    )
                  : Container(
                      child: Center(
                        child: Text('No match data. Start a new one below.'),
                      ),
                    );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createNewMatch(context),
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            MediaQuery.of(context).orientation == Orientation.portrait
                ? FloatingActionButtonLocation.centerFloat
                : FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _createNewMatch(BuildContext context) async {
    setState(() {
      _opacity = 0.5;
    });

    await showDialog(
        context: context,
        builder: (_) {
          return NewMatch();
        }).then((value) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _showScoreInfo(BuildContext context) async {
    setState(() {
      _opacity = 0.5;
    });
    await showDialog(
        context: context,
        builder: (_) {
          return InfoWidget();
        }).then((value) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }
}
