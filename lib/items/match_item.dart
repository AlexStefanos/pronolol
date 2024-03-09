import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/modals/prediction_modal.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/utils/colors.dart';

class MatchItem extends StatefulWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.match.isFutureMatch &&
            !widget.match.currentUserHasPredicted) {
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
                const Expanded(child: SizedBox(width: 1)),
                if (widget.match.currentUserHasPredicted &&
                    widget.match.isFutureMatch) ...[
                  IconButton(
                    onPressed: () {
                      if (widget.match.isFutureMatch &&
                          widget.match.currentUserHasPredicted) {
                        showBetModal(context);
                      }
                    },
                    icon: const Icon(Icons.edit_square),
                    iconSize: 30.0,
                  )
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
                      fontFamily: "monospace",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                                fontFamily: "monospace",
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
                            left: 18,
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
                      fontFamily: "monospace",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
            ),
          ],
        ),
      ),
    );
  }
}
