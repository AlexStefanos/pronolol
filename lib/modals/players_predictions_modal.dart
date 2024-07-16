import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/models/match_model.dart';

class PlayersPredictionsModal extends StatefulWidget {
  final Match match;

  const PlayersPredictionsModal(this.match, {super.key});

  @override
  State<PlayersPredictionsModal> createState() =>
      _PlayersPredictionsModalState();
}

class _PlayersPredictionsModalState extends State<PlayersPredictionsModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                const Expanded(child: SizedBox(width: 1)),
                Image.network(
                  widget.match.team1.logo,
                  height: 50,
                  width: 50,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(width: 10),
                Text(widget.match.team1.cleanTricode()),
                const Expanded(child: SizedBox(width: 1)),
                const Text('-'),
                const Expanded(child: SizedBox(width: 1)),
                Text(widget.match.team2.cleanTricode()),
                const SizedBox(width: 10),
                Image.network(
                  widget.match.team2.logo,
                  width: 50,
                  alignment: Alignment.center,
                ),
                const Expanded(child: SizedBox(width: 1)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: PostgresApi.getMatchPredictionsById(widget.match.id),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                      child: Column(
                        children: [
                          for (var prediction in snapshot.data!)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${prediction.result == widget.match.score ? '✅' : widget.match.score != null ? '❌' : ''} ${prediction.user.name} ${prediction.user.emoji}',
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${prediction.result[0]} - ${prediction.result[1]}',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ]),
    ));
  }
}
