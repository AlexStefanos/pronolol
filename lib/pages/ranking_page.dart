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
  var _tournamentChosen = Tournaments.global;

  void _disconnection() async {
    User.currentUser = null;
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.clear();
    Restart.restartApp();
  }

  List<int> getScoresList(scoresList) {
    List<int> result = [];
    for (var elem in scoresList) {
      result.add(elem.value);
    }
    return result;
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
            const SizedBox(
              width: 115,
            ),
            DropdownButton<Tournaments>(
              value: _tournamentChosen,
              icon: const Icon(
                Icons.menu_open,
                size: 22,
              ),
              items: const [
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.global, child: Text('Global          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.lec, child: Text('LEC          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.lck, child: Text('LCK          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.lpl, child: Text('LPL          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.msi, child: Text('MSI          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.worlds, child: Text('Worlds          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.lfl, child: Text('LFL          ')),
                DropdownMenuItem<Tournaments>(
                    value: Tournaments.eum, child: Text('EUM          ')),
              ],
              onChanged: (tournament) {
                if (tournament == Tournaments.global) {
                  setState(() {
                    _tournamentChosen = Tournaments.global;
                    _currentRanking = PostgresApi.getCurrentRanking();
                    _globalRanking = PostgresApi.getGlobalRanking();
                  });
                } else if (tournament == Tournaments.lec) {
                  setState(() {
                    _tournamentChosen = Tournaments.lec;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('LEC');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('LEC');
                  });
                } else if (tournament == Tournaments.lck) {
                  setState(() {
                    _tournamentChosen = Tournaments.lck;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('LCK');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('LCK');
                  });
                } else if (tournament == Tournaments.lpl) {
                  setState(() {
                    _tournamentChosen = Tournaments.lpl;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('LPL');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('LPL');
                  });
                } else if (tournament == Tournaments.msi) {
                  setState(() {
                    _tournamentChosen = Tournaments.msi;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('MSI');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('MSI');
                  });
                } else if (tournament == Tournaments.worlds) {
                  setState(() {
                    _tournamentChosen = Tournaments.worlds;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('WORLDS');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('WORLDS');
                  });
                } else if (tournament == Tournaments.lfl) {
                  setState(() {
                    _tournamentChosen = Tournaments.lfl;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('LFL');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('LFL');
                  });
                } else if (tournament == Tournaments.eum) {
                  setState(() {
                    _tournamentChosen = Tournaments.eum;
                    _currentRanking =
                        PostgresApi.getSpecificCurrentRanking('EUM');
                    _globalRanking =
                        PostgresApi.getSpecificGlobalRanking('EUM');
                  });
                }
              },
            ),
            const Expanded(
                child: SizedBox(
              width: 1,
            )),
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
            tabs: [Tab(text: 'Split/Tournoi en cours'), Tab(text: 'Total')],
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
                            i + 1,
                            getScoresList(snapshot.data!)),
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
                            i + 1,
                            getScoresList(snapshot.data!)),
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
