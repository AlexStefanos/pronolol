// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/data/players_data.dart';
import 'package:pronolol/items/match_item.dart';
import 'package:pronolol/items/player_item.dart';
import 'package:pronolol/models/player_model.dart';
import 'package:pronolol/models/match_model.dart';

class ResultsPage extends StatefulWidget {
  List<Player> playerRanking = [];

  ResultsPage({super.key}) {
    playerRanking = playersData.keys.map((key) => Player(key)).toList();
    log("test");
    for (Match match in FirebaseApi.pastMatches) {
      for (var prediction in match.predictions.entries) {
        if (match.hasPredicted(prediction.key)) {
          if (match.hasPerfectWin(prediction.key)) {
            playerRanking
                .firstWhere((player) => player.name == prediction.key)
                .score += 3;
          } else if (match.hasWin(prediction.key)) {
            playerRanking
                .firstWhere((player) => player.name == prediction.key)
                .score += 1;
          } else {
            //totalScore += 0;
          }
        } else {
          //totalScore += 0;
        }
      }
      playerRanking
          .sort(((player1, player2) => player2.score.compareTo(player1.score)));
    }
  }

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Mes Pronos',
            ),
            Tab(
              text: 'Classement',
            )
          ]),
        ),
        body: TabBarView(children: [
          FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: FirebaseApi.playerPredictions.length,
                  itemBuilder: (ctx, i) =>
                      MatchItem(FirebaseApi.playerPredictions[i]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: FirebaseApi.getPredictedMatches(),
          ),
          ListView.builder(
            itemCount: widget.playerRanking.length,
            itemBuilder: (ctx, i) => PlayerItem(widget.playerRanking[i], i),
          )
        ]),
      ),
    );
  }
}
