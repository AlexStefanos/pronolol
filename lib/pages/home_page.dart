import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/match_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    itemCount: FirebaseApi.sortedBetMatchesByDateDesc.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.sortedBetMatchesByDateDesc[i]),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.fetchNextMatches(),
            ),
            FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    itemCount: FirebaseApi.sortedMatchesByDateDesc.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(FirebaseApi.sortedMatchesByDateDesc[i]),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: FirebaseApi.fetchLastMatches(10),
            ),
            
          ])),
    );
  }
}
