import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/match_item.dart';
import 'package:pronolol/modals/side_drawer_modal.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/ranking_page.dart';
import 'package:pronolol/utils/colors.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentSplit = '';

  void _disconnection() async {
    User.currentUser = null;
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
    Restart.restartApp();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await PostgresApi.getCurrentSplit().then((value) => setState(() {
            currentSplit = value;
          }));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const SideDrawer(),
        appBar: AppBar(
          title: const Text('pronolol'),
          actions: [
            IconButton(
              onPressed: _disconnection,
              icon: const Icon(Icons.exit_to_app),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(User.currentUser!.emoji),
            ),
          ],
          bottom: TabBar(
              tabs: const [Tab(text: 'À Venir'), Tab(text: 'Passés')],
              labelColor: appColors['FUTURE'],
              indicatorColor: appColors['FUTURE']),
        ),
        body: TabBarView(children: [
          RefreshIndicator(
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx, i) => i == 0 ||
                              snapshot.data?[i].date.day !=
                                  snapshot.data?[i - 1].date.day
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                  Center(
                                    child: Text(
                                      snapshot.data![i].literatureDate,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  MatchItem(snapshot.data![i], 'à Venir',
                                      currentSplit)
                                ])
                          : MatchItem(
                              snapshot.data![i], 'à Venir', currentSplit));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: PostgresApi.getMatchesToCome(),
            ),
            onRefresh: () {
              return Future(() {
                setState(() {});
              });
            },
          ),
          RefreshIndicator(
            child: FutureBuilder(
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 59,
                    itemBuilder: (ctx, i) =>
                        MatchItem(snapshot.data![i], 'passés', currentSplit),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: PostgresApi.getPastMatches(),
            ),
            onRefresh: () {
              return Future(() {
                setState(() {});
              });
            },
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Text('🏆', style: TextStyle(fontSize: 40)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RankingPage()));
          },
        ),
      ),
    );
  }
}
