import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/ranking_item.dart';
import 'package:pronolol/models/user_model.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: const Text('pronolol'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(User.currentUser!.emoji),
                  )
                ],
                bottom: const TabBar(tabs: [
                  Tab(text: 'Split Actuel'),
                  Tab(text: 'Split Précédents')
                ])),
            body: TabBarView(children: [
              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx, i) => RankingItem(
                          snapshot.data![i].key,
                          snapshot.data![i].value,
                          i + 1),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                future: PostgresApi.getCurrentRanking(),
              ),
              FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx, i) => RankingItem(
                          snapshot.data![i].key,
                          snapshot.data![i].value,
                          i + 1),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                future: PostgresApi.getGlobalRanking(),
              )
            ])));
  }
}
