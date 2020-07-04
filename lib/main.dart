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
  static const String title = '500 Score Keeping';
  @override
  Widget build(BuildContext context) {
    return Consumer<MatchStateNotifier>(
      builder: (context, matchState, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: MyHomePage(title: title),
        );
      },
    );
  }
}
