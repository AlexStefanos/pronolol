import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/ranking_item.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  void _disconnection() async {
    User.currentUser = null;
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
    Restart.restartApp();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('pronolol'),
          actions: [
            IconButton(
              onPressed: _disconnection,
              icon: const Icon(Icons.login),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(User.currentUser!.emoji),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Score du Split Actuel'),
              Tab(text: 'Score Total')
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (ctx, i) => RankingItem(
                            snapshot.data![i].key,
                            snapshot.data![i].value,
                            snapshot.data!.length,
                            i + 1),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  future: PostgresApi.getCurrentRanking(),
                ),
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                }),
            RefreshIndicator(
                child: FutureBuilder(
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (ctx, i) => RankingItem(
                            snapshot.data![i].key,
                            snapshot.data![i].value,
                            snapshot.data!.length,
                            i + 1),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  future: PostgresApi.getGlobalRanking(),
                ),
                onRefresh: () {
                  return Future(() {
                    setState(() {});
                  });
                }),
          ],
        ),
      ),
    );
  }
}
