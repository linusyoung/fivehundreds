import 'package:fivehundreds/match_data_helper.dart';
import 'package:fivehundreds/model/models.dart';
import 'package:flutter/material.dart';

class MatchStateNotifier extends ChangeNotifier {
  MatchInfo matchInfo;
  Future<void> updateMatchState(String uuid, MatchInfo matchInfo) async {
    this.matchInfo = matchInfo;
    notifyListeners();
    var match = matchInfo.toJson();
    await MatchDataHelper.setMatchInfo(uuid, match);
  }
}
