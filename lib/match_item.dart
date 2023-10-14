import 'package:flutter/material.dart';
import 'package:pronolol/models/match.dart';

class MatchItem extends StatelessWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${match.team1.name} vs ${match.team2.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(
                  match.score,
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
