import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/data/teams_data.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/team_model.dart';

class BetModal extends StatefulWidget {
  final Match match;

  const BetModal(this.match, {super.key});

  @override
  State<BetModal> createState() => _BetModalState();
}

class _BetModalState extends State<BetModal> {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                winner = widget.match.team1;
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
                    teamsLogo[widget.match.team1.name]!,
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(widget.match.team1.name),
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  winner = widget.match.team2;
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
                    teamsLogo[widget.match.team2.name]!,
                    height: 50,
                    width: 50,
                    alignment: Alignment.centerLeft,
                  ),
                  Text(widget.match.team2.name),
                ]),
              ),
            ),
          ],
        ),
        if (winner != null) ...[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DropdownMenu<int>(
              enabled: winner != widget.match.team1,
              initialSelection: winner == widget.match.team1
                  ? (widget.match.bo / 2).ceil()
                  : 0,
              dropdownMenuEntries: generateBoList(widget.match.team1),
              onSelected: (value) => setState(() {
                bet1 = value;
              }),
            ),
            DropdownMenu<int>(
              enabled: winner != widget.match.team2,
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
              onPressed: () async =>
                  await FirebaseApi.predict(widget.match.id, '$bet1$bet2'),
              icon: const Icon(Icons.check))
        ]
      ]),
    )));
  }
}
