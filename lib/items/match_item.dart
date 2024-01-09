import 'package:flutter/material.dart';
import 'package:pronolol/data/teams_data.dart';
import 'package:pronolol/modals/bet_modal.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/user_model.dart';

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

  void openMatchPage() {}

  void showBetModal(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return BetModal(match);
        });
  }

  MaterialColor getMatchColor() {
    if (!match.isFutureMatch()) {
      if (match.hasPredicted(User.name ?? '')) {
        if (match.hasPerfectWin(User.name ?? '')) {
          return Colors.amber;
        } else if (match.hasWin(User.name ?? '')) {
          return Colors.green;
        } else {
          return Colors.red;
        }
      } else {
        return Colors.grey;
      }
    } else {
      if (match.canPredict(User.name ?? '')) {
        return Colors.teal;
      } else {
        return Colors.grey;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          (((match.isFutureMatch()) && (!match.canPredict(User.name ?? ''))) ||
                  !match.isFutureMatch())
              ? openMatchPage()
              : showBetModal(context),
      child: Card(
        color: getMatchColor(),
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
