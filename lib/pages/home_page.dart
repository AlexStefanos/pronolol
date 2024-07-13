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
    _tournamentChosen = Tournaments.global;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await PostgresApi.getCurrentTournament().then((value) => setState(() {
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
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('LFL');
        _pastMatches = PostgresApi.getSpecificPastMatches('LFL');
      });
    } else if (widget.tournament == Tournaments.eum) {
      setState(() {
        _tournamentChosen = Tournaments.eum;
        _matchesToCome = PostgresApi.getSpecificMatchesToCome('EUM');
        _pastMatches = PostgresApi.getSpecificPastMatches('EUM');
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
                    _matchesToCome = PostgresApi.getMatchesToCome();
                    _pastMatches = PostgresApi.getPastMatches();
                  });
                } else if (tournament == Tournaments.lec) {
                  setState(() {
                    _tournamentChosen = Tournaments.lec;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('LEC');
                    _pastMatches = PostgresApi.getSpecificPastMatches('LEC');
                  });
                } else if (tournament == Tournaments.lck) {
                  setState(() {
                    _tournamentChosen = Tournaments.lck;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('LCK');
                    _pastMatches = PostgresApi.getSpecificPastMatches('LCK');
                  });
                } else if (tournament == Tournaments.lpl) {
                  setState(() {
                    _tournamentChosen = Tournaments.lpl;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('LPL');
                    _pastMatches = PostgresApi.getSpecificPastMatches('LPL');
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
                        PostgresApi.getSpecificMatchesToCome('LFL');
                    _pastMatches = PostgresApi.getSpecificPastMatches('LFL');
                  });
                } else if (tournament == Tournaments.eum) {
                  setState(() {
                    _tournamentChosen = Tournaments.eum;
                    _matchesToCome =
                        PostgresApi.getSpecificMatchesToCome('EUM');
                    _pastMatches = PostgresApi.getSpecificPastMatches('EUM');
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
                setState(() {
                  if (_tournamentChosen == Tournaments.global) {
                    setState(() {
                      _matchesToCome = PostgresApi.getMatchesToCome();
                    });
                  } else if (_tournamentChosen == Tournaments.lec) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('LEC');
                    });
                  } else if (_tournamentChosen == Tournaments.lck) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('LCK');
                    });
                  } else if (_tournamentChosen == Tournaments.lpl) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('LPL');
                    });
                  } else if (_tournamentChosen == Tournaments.msi) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('MSI');
                    });
                  } else if (_tournamentChosen == Tournaments.worlds) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('WORLDS');
                    });
                  } else if (_tournamentChosen == Tournaments.lfl) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('LFL');
                    });
                  } else if (_tournamentChosen == Tournaments.eum) {
                    setState(() {
                      _matchesToCome =
                          PostgresApi.getSpecificMatchesToCome('EUM');
                    });
                  }
                });
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
                setState(() {
                  if (_tournamentChosen == Tournaments.global) {
                    setState(() {
                      _pastMatches = PostgresApi.getPastMatches();
                    });
                  } else if (_tournamentChosen == Tournaments.lec) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('LEC');
                    });
                  } else if (_tournamentChosen == Tournaments.lck) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('LCK');
                    });
                  } else if (_tournamentChosen == Tournaments.lpl) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('LPL');
                    });
                  } else if (_tournamentChosen == Tournaments.msi) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('MSI');
                    });
                  } else if (_tournamentChosen == Tournaments.worlds) {
                    setState(() {
                      _pastMatches =
                          PostgresApi.getSpecificPastMatches('WORLDS');
                    });
                  } else if (_tournamentChosen == Tournaments.lfl) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('LFL');
                    });
                  } else if (_tournamentChosen == Tournaments.eum) {
                    setState(() {
                      _pastMatches = PostgresApi.getSpecificPastMatches('EUM');
                    });
                  }
                });
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
