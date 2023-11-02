import 'package:flutter/material.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:pronolol/prono.dart';

class MatchItem extends StatelessWidget {
  final Match match;
  final String user;

  const MatchItem(this.match, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    void addPronoOverlay() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => Prono(match, user),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              match.teamA.imageUrl,
              height: 50,
              width: 50,
              alignment: Alignment.centerLeft,
            ),
            Text(match.toString()),
            Image.network(
              match.teamB.imageUrl,
              height: 50,
              width: 50,
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(width: 30),
            IconButton(
              onPressed: addPronoOverlay,
              icon: const Icon(Icons.bento),
              alignment: Alignment.centerRight,
            ),
          ],
        ),
      ),
    );
  }
}
