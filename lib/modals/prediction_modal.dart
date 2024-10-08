import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/team_model.dart';

class PredictionModal extends StatefulWidget {
  final Match match;

  const PredictionModal(this.match, {super.key});

  @override
  State<PredictionModal> createState() => _PredictionModalState();
}

class _PredictionModalState extends State<PredictionModal> {
  int? bet1 = 0;
  int? bet2 = 0;
  Team? winner;

  // Create function that generate a list of int from 0 to n
  List<DropdownMenuEntry<int>> generateBoList(Team team) {
    return List.generate(
            (winner == team
                    ? (widget.match.bo / 2).ceil()
                    : (widget.match.bo / 2).floor()) +
                1,
            (index) => index)
        .map((e) => DropdownMenuEntry(value: e, label: e.toString()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('BO: ${widget.match.bo} Date: ${widget.match.numericalDate}'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                winner = widget.match.team1;
                bet2 = bet1;
                bet1 = (widget.match.bo / 2).ceil();
              }),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: winner == widget.match.team1
                          ? Colors.green
                          : Colors.transparent,
                      width: 3),
                  shape: BoxShape.circle,
                ),
                child: Column(children: [
                  Image.network(
                    widget.match.team1.logo,
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(widget.match.team1.cleanTricode()),
                ]),
              ),
            ),
            const Text('-'),
            GestureDetector(
              onTap: () {
                setState(() {
                  winner = widget.match.team2;
                  bet1 = bet2;
                  bet2 = (widget.match.bo / 2).ceil();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: winner == widget.match.team2
                          ? Colors.green
                          : Colors.transparent,
                      width: 3),
                  shape: BoxShape.circle,
                ),
                child: Column(children: [
                  Image.network(
                    widget.match.team2.logo,
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(widget.match.team2.cleanTricode()),
                ]),
              ),
            ),
          ],
        ),
        if (widget.match.currentUserHasPredicted) ...[
          const Text('BAH ALORS TU DOUTES ???'),
          const SizedBox(height: 15),
        ],
        if (winner != null) ...[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DropdownMenu<int>(
              enabled: winner != widget.match.team1 && widget.match.bo > 1,
              initialSelection: winner == widget.match.team1
                  ? (widget.match.bo / 2).ceil()
                  : 0,
              dropdownMenuEntries: generateBoList(widget.match.team1),
              onSelected: (value) => setState(() {
                bet1 = value;
              }),
            ),
            DropdownMenu<int>(
              enabled: winner != widget.match.team2 && widget.match.bo > 1,
              initialSelection: winner == widget.match.team2
                  ? (widget.match.bo / 2).ceil()
                  : 0,
              dropdownMenuEntries: generateBoList(widget.match.team2),
              onSelected: (value) => setState(() {
                bet2 = value;
              }),
            )
          ]),
          IconButton(
              onPressed: () async {
                if (widget.match.currentUserHasPredicted) {
                  await PostgresApi.updatePrediction(
                      widget.match.id, '$bet1$bet2');
                  widget.match.currentUserPrediction = '$bet1$bet2';
                } else {
                  await PostgresApi.addPrediction(
                      widget.match.id, '$bet1$bet2');
                  widget.match.currentUserPrediction = '$bet1$bet2';
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.check)),
        ]
      ]),
    )));
  }
}
