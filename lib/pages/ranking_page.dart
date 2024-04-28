import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/ranking_item.dart';
import 'package:pronolol/modals/side_drawer_modal.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/utils/tournaments.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RankingPage extends StatefulWidget {
  final Tournaments tournament;

  const RankingPage(this.tournament, {super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  var _currentRanking = PostgresApi.getCurrentRanking();
  var _globalRanking = PostgresApi.getGlobalRanking();

  void _disconnection() async {
    User.currentUser = null;
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
    Restart.restartApp();
  }

  @override
  void initState() {
    if (widget.tournament == Tournaments.global) {
      setState(() {
        _currentRanking = PostgresApi.getCurrentRanking();
        _globalRanking = PostgresApi.getGlobalRanking();
      });
    } else if (widget.tournament == Tournaments.lec) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('LEC');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('LEC');
      });
    } else if (widget.tournament == Tournaments.lck) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('LCK');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('LCK');
      });
    } else if (widget.tournament == Tournaments.lpl) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('LPL');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('LPL');
      });
    } else if (widget.tournament == Tournaments.msi) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('MSI');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('MSI');
      });
    } else if (widget.tournament == Tournaments.worlds) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('WORLDS');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('WORLDS');
      });
    } else if (widget.tournament == Tournaments.lfl) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('LFL');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('LFL');
      });
    } else if (widget.tournament == Tournaments.eum) {
      setState(() {
        _currentRanking = PostgresApi.getSpecificCurrentRanking('EUM');
        _globalRanking = PostgresApi.getSpecificGlobalRanking('EUM');
      });
    }
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
            DropdownMenu(
                width: 200,
                inputDecorationTheme: InputDecorationTheme(
                  constraints: BoxConstraints.tight(const Size.fromHeight(55)),
                ),
                label: const Text(
                  '(Cliquer pour choisir un tournoi à afficher)',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                onSelected: (tournament) {
                  if (tournament == Tournaments.global) {
                    setState(() {
                      _currentRanking = PostgresApi.getCurrentRanking();
                      _globalRanking = PostgresApi.getGlobalRanking();
                    });
                  } else if (tournament == Tournaments.lec) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('LEC');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('LEC');
                    });
                  } else if (tournament == Tournaments.lck) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('LCK');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('LCK');
                    });
                  } else if (tournament == Tournaments.lpl) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('LPL');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('LPL');
                    });
                  } else if (tournament == Tournaments.msi) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('MSI');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('MSI');
                    });
                  } else if (tournament == Tournaments.worlds) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('WORLDS');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('WORLDS');
                    });
                  } else if (tournament == Tournaments.lfl) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('lfl');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('lfl');
                    });
                  } else if (tournament == Tournaments.eum) {
                    setState(() {
                      _currentRanking =
                          PostgresApi.getSpecificCurrentRanking('eum');
                      _globalRanking =
                          PostgresApi.getSpecificGlobalRanking('eum');
                    });
                  }
                },
                dropdownMenuEntries: const <DropdownMenuEntry<Tournaments>>[
                  DropdownMenuEntry(value: Tournaments.global, label: 'Global'),
                  DropdownMenuEntry(value: Tournaments.lec, label: 'LEC'),
                  DropdownMenuEntry(value: Tournaments.lck, label: 'LCK'),
                  DropdownMenuEntry(value: Tournaments.lpl, label: 'LPL'),
                  DropdownMenuEntry(value: Tournaments.msi, label: 'MSI'),
                  DropdownMenuEntry(value: Tournaments.worlds, label: 'WORLDS'),
                  DropdownMenuEntry(value: Tournaments.lfl, label: 'LFL'),
                  DropdownMenuEntry(value: Tournaments.eum, label: 'EUM'),
                ]),
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
                  future: _currentRanking,
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
                  future: _globalRanking,
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
