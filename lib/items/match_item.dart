import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/modals/players_predictions_modal.dart';
import 'package:pronolol/modals/prediction_modal.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/utils/colors.dart';

class MatchItem extends StatefulWidget {
  final Match match;
  final String pageKey, currentSplit;

  const MatchItem(this.match, this.pageKey, this.currentSplit, {super.key});

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  var _isOpen = false;

  void showBetModal(BuildContext ctx) async {
    var value = await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return PredictionModal(widget.match);
        });
    setState(() {
      if (value != null) {
        widget.match.currentUserPrediction = value;
      }
    });
  }

  void showPlayersPredictions(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return PlayersPredictionsModal(widget.match);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.match.isFutureMatch) {
          showBetModal(context);
        } else {
          setState(() {
            _isOpen = !_isOpen;
          });
        }
      },
      child: Card(
        color: widget.match.isFutureMatch
            ? widget.match.currentUserHasPredicted
                ? appColors['PREDICTED']
                : appColors['FUTURE']
            : appColors['PAST'],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (widget.match.isFutureMatch) ...[
                  const SizedBox(width: 15, height: 40),
                  if ((widget.match.tournament.nameDisplay() != 'MSI') ||
                      (widget.match.tournament.nameDisplay() != 'Worlds')) ...[
                    Text(
                      '${widget.match.tournament.nameDisplay()}, ${widget.match.numericalDate}, BO : ${widget.match.bo}, ${widget.match.numericalSchedule}',
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  ] else ...[
                    Text(
                      '${widget.currentSplit}, BO : ${widget.match.bo}, ${widget.match.numericalSchedule}',
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  ],
                  const Expanded(child: SizedBox(width: 1)),
                  IconButton(
                    onPressed: () {
                      showPlayersPredictions(context);
                    },
                    icon: const Icon(Icons.assignment),
                    iconSize: 30.0,
                  )
                ] else ...[
                  if ((widget.match.tournament.nameDisplay() != 'MSI') ||
                      (widget.match.tournament.nameDisplay() != 'Worlds')) ...[
                    const SizedBox(width: 15, height: 40),
                    Text(
                      '${widget.currentSplit}, ${widget.match.numericalDate}, ${widget.match.numericalSchedule}',
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  ] else ...[
                    Text(
                      '${widget.match.tournament.nameDisplay()}, ${widget.match.numericalDate}, ${widget.match.numericalSchedule}',
                      style: const TextStyle(
                          fontSize: 17, fontStyle: FontStyle.italic),
                    ),
                  ],
                ],
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    widget.match.team1.logo,
                    width: 50,
                    alignment: Alignment.center,
                  ),
                  Text(
                    widget.match.team1.name.padLeft(3),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  if (widget.pageKey != 'passés') ...[
                    const Text('-'),
                  ],
                  if (widget.match.score != null) ...[
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 5,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${widget.match.score![0]} - ${widget.match.score![1]}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: widget.match.isCurrentUserWinner
                                    ? appColors['WIN']
                                    : appColors['LOSE'],
                              ),
                            ),
                          ),
                        ),
                        if (widget.match.isCurrentUserPerfectWinner) ...[
                          Positioned(
                            left: 8.5,
                            top: -22,
                            child: Image.network(
                              'https://i.pinimg.com/originals/39/1a/96/391a964218aa5d42228201804286641c.png',
                              alignment: Alignment.center,
                              height: 25,
                            ),
                          ),
                        ]
                      ],
                    )
                  ],
                  Text(
                    widget.match.team2.name.padRight(3),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Image.network(
                    widget.match.team2.logo,
                    width: 50,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            if (widget.pageKey == 'passés') ...[
              Visibility(
                visible: _isOpen,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
            ],
          ],
        ),
      ),
    );
  }
}
