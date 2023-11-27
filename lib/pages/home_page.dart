import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/match_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const user = "Caribou";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('pronolol'),
            bottom: const TabBar(tabs: [
              Tab(
                text: "À venir",
              ),
              Tab(
                text: "Passés",
              )
            ]),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: FirebaseApi.futureMatches.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.futureMatches[i], false),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.getFutureMatches(),
            ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: FirebaseApi.pastOrPredictedMatches.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.pastOrPredictedMatches[i], true),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.getPastMatches(),
            ),
          ])),
    );
  }
}
