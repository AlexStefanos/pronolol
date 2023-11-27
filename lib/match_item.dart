import 'package:flutter/material.dart';
import 'package:pronolol/data/teams_data.dart';
import 'package:pronolol/modals/bet_modal.dart';
import 'package:pronolol/models/match_model.dart';

class MatchItem extends StatelessWidget {
  final Match match;
  final bool isFutureMatch;

  const MatchItem(this.match, this.isFutureMatch, {super.key});

  void openMatchPage() {}

  void showBetModal(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return BetModal(match);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => isFutureMatch ? openMatchPage() : showBetModal(context),
      child: Card(
        color: isFutureMatch
            ? match.hasPredicted()
                ? match.hasPerfectWin()
                    ? Colors.amber
                    : match.hasWin()
                        ? Colors.green
                        : Colors.red
                : Colors.grey
            : match.canPredict()
                ? Colors.teal
                : Colors.grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                teamsLogo[match.team1.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              Text(match.toString()),
              Image.network(
                teamsLogo[match.team2.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
