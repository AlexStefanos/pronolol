import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/items/match_item.dart';
import 'package:pronolol/modals/side_drawer_modal.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/ranking_page.dart';
import 'package:pronolol/utils/colors.dart';
import 'package:pronolol/utils/tournaments.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Tournaments tournament;

  const HomePage(this.tournament, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentSplit = '';
  var _tournamentChosen = Tournaments.global;
  var _matchesToCome = PostgresApi.getMatchesToCome();
  var _pastMatches = PostgresApi.getPastMatches();

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
            _currentSplit = value;
          }));
    });
    if (widget.tournament == Tournaments.global) {
      setState(() {
        _tournamentChosen = Tournaments.global;
        _matchesToCome = PostgresApi.getMatchesToCome();
        _pastMatches = PostgresApi.getPastMatches();
      });
    } else if (widget.tournament == Tournaments.lec) {
      setState(() {
        _tournamentChosen = Tournaments.lec;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('LEC');
        _pastMatches = PostgresApi.getSpecificPastMatches('LEC');
      });
    } else if (widget.tournament == Tournaments.lck) {
      setState(() {
        _tournamentChosen = Tournaments.lck;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('LCK');
        _pastMatches = PostgresApi.getSpecificPastMatches('LCK');
      });
    } else if (widget.tournament == Tournaments.lpl) {
      setState(() {
        _tournamentChosen = Tournaments.lpl;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('LPL');
        _pastMatches = PostgresApi.getSpecificPastMatches('LPL');
      });
    } else if (widget.tournament == Tournaments.msi) {
      setState(() {
        _tournamentChosen = Tournaments.msi;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('MSI');
        _pastMatches = PostgresApi.getSpecificPastMatches('MSI');
      });
    } else if (widget.tournament == Tournaments.worlds) {
      setState(() {
        _tournamentChosen = Tournaments.worlds;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('WORLDS');
        _pastMatches = PostgresApi.getSpecificPastMatches('WORLDS');
      });
    } else if (widget.tournament == Tournaments.lfl) {
      setState(() {
        _tournamentChosen = Tournaments.lfl;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('lfl');
        _pastMatches = PostgresApi.getSpecificPastMatches('lfl');
      });
    } else if (widget.tournament == Tournaments.eum) {
      setState(() {
        _tournamentChosen = Tournaments.eum;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('eum');
        _pastMatches = PostgresApi.getSpecificPastMatches('eum');
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
                    _tournamentChosen = Tournaments.global;
                    _matchesToCome = PostgresApi.getMatchesToCome();
                    _pastMatches = PostgresApi.getPastMatches();
                  });
                } else if (tournament == Tournaments.lec) {
                  setState(() {
                    _tournamentChosen = Tournaments.lec;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('lec');
                    _pastMatches = PostgresApi.getSpecificPastMatches('lec');
                  });
                } else if (tournament == Tournaments.lck) {
                  setState(() {
                    _tournamentChosen = Tournaments.lck;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('lck');
                    _pastMatches = PostgresApi.getSpecificPastMatches('lck');
                  });
                } else if (tournament == Tournaments.lpl) {
                  setState(() {
                    _tournamentChosen = Tournaments.lpl;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('lpl');
                    _pastMatches = PostgresApi.getSpecificPastMatches('lpl');
                  });
                } else if (tournament == Tournaments.msi) {
                  setState(() {
                    _tournamentChosen = Tournaments.msi;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('MSI');
                    _pastMatches = PostgresApi.getSpecificPastMatches('MSI');
                  });
                } else if (tournament == Tournaments.worlds) {
                  setState(() {
                    _tournamentChosen = Tournaments.worlds;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('WORLDS');
                    _pastMatches = PostgresApi.getSpecificPastMatches('WORLDS');
                  });
                } else if (tournament == Tournaments.lfl) {
                  setState(() {
                    _tournamentChosen = Tournaments.lfl;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('lfl');
                    _pastMatches = PostgresApi.getSpecificPastMatches('lfl');
                  });
                } else if (tournament == Tournaments.eum) {
                  setState(() {
                    _tournamentChosen = Tournaments.eum;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('eum');
                    _pastMatches = PostgresApi.getSpecificPastMatches('eum');
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
              ],
            ),
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
                                      _currentSplit)
                                ])
                          : MatchItem(
                              snapshot.data![i], 'à Venir', _currentSplit));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: _matchesToCome,
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
                    itemCount: (snapshot.data!.length >= 59)
                        ? 59
                        : snapshot.data!.length,
                    itemBuilder: (ctx, i) =>
                        MatchItem(snapshot.data![i], 'passés', _currentSplit),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
              future: _pastMatches,
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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => RankingPage(_tournamentChosen)))),
        ),
      ),
    );
  }
}
