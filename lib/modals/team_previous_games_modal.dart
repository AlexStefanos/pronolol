import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/models/team_model.dart';

class TeamPreviousGamesModal extends StatefulWidget {
  final Team team;

  const TeamPreviousGamesModal(this.team, {super.key});

  @override
  State<TeamPreviousGamesModal> createState() => _TeamPreviousGamesModalState();
}

class _TeamPreviousGamesModalState extends State<TeamPreviousGamesModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          child: Column(
        children: [
          Row(
            children: [
              const Expanded(child: SizedBox(width: 1)),
              IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (ctx, i) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                              child: Row(
                            children: [
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Text(
                                '${snapshot.data![i].numericalDate}: ',
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Image.network(
                                snapshot.data![i].team1.logo,
                                width: 25,
                                alignment: Alignment.center,
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Text(
                                snapshot.data![i].team1.cleanTricode(),
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Text(
                                ' ${snapshot.data![i].score}  ',
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Text(
                                snapshot.data![i].team2.cleanTricode(),
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Image.network(
                                snapshot.data![i].team2.logo,
                                width: 25,
                                alignment: Alignment.center,
                              ),
                              const Expanded(
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
                future: PostgresApi.getTeamPreviousMatches(widget.team.name)),
          ),
        ],
      )),
    );
  }
}
