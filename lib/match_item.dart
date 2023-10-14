import 'package:flutter/material.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/prono.dart';

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    void _addPronoOverlay() {
      showModalBottomSheet(context: context, builder: (ctx) => Prono());
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Column(
          children: [
            IconButton(
                onPressed: _addPronoOverlay, icon: const Icon(Icons.bento)),
            Text(
              '${match.team1.name} ${match.team1.country.flag} vs ${match.team2.name} ${match.team2.country.flag}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(match.score),
            Text(match.formattedDate),
          ],
        ),
      ),
    );
  }
}
