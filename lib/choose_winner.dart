import 'package:flutter/material.dart';
import 'package:pronolol/data/teams_data.dart';
import 'package:pronolol/models/team_model.dart';

class ChooseWinner extends StatefulWidget {
  final Team team1;
  final Team team2;
  final Function onSelected;

  const ChooseWinner(this.team1, this.team2, this.onSelected, {super.key});

  @override
  State<ChooseWinner> createState() => _ChooseWinnerState();
}

class _ChooseWinnerState extends State<ChooseWinner> {
  Team? winner;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => setState(() => widget.onSelected()),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:
                  winner == widget.team1 ? Colors.orange : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Column(children: [
              Image.network(
                teamsLogo[widget.team1.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              Text(widget.team1.name),
            ]),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => winner = widget.team2),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color:
                  winner == widget.team2 ? Colors.orange : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Column(children: [
              Image.network(
                teamsLogo[widget.team2.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              Text(widget.team2.name),
            ]),
          ),
        ),
      ],
    );
  }
}
