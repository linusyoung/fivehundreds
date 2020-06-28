import 'package:fivehundreds/model/models.dart';
import 'package:fivehundreds/pages/pages.dart';
import 'package:fivehundreds/utils.dart/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<MatchStateNotifier>(
      create: (context) => MatchStateNotifier(),
      child: FiveHundredScorerApp()));
}

class FiveHundredScorerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<MatchStateNotifier>(
      builder: (context, matchState, child) {
        return MaterialApp(
          title: '500 Scorer',
          theme: AppTheme.lightTheme,
          home: MyHomePage(title: '500 Scorer'),
        );
      },
    );
  }
}
