import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/items/match_item.dart';
import 'package:pronolol/items/player_item.dart';

class PredictionsPage extends StatefulWidget {
  final String username;
  const PredictionsPage(this.username, {super.key});

  @override
  State<PredictionsPage> createState() => _PredictionsPageState();
}

class _PredictionsPageState extends State<PredictionsPage> {
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
            future: FirebaseApi.getPlayersPredictions(widget.username),
          ),
          FutureBuilder(
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: FirebaseApi.playersRanking.length,
                  itemBuilder: (ctx, i) =>
                      PlayerItem(FirebaseApi.playersRanking[i]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            future: FirebaseApi.getPastMatches(),
          ),
        ]),
      ),
    );
  }
}
