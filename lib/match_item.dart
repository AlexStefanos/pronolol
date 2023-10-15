import 'package:flutter/material.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:pronolol/prono.dart';

class MatchItem extends StatelessWidget {
  final int index;

  const MatchItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final Image imageTeamA = Image.network(
      LolEsportApi.previousMatches[index].teamA.imageUrl,
      height: 50,
      width: 50,
    );
    final Image imageTeamB = Image.network(
      LolEsportApi.previousMatches[index].teamB.imageUrl,
      height: 50,
      width: 50,
    );
    void _addPronoOverlay() {
      showModalBottomSheet(context: context, builder: (ctx) => Prono(index));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            imageTeamA,
            Text(LolEsportApi.previousMatches[index].toString()),
            imageTeamB,
            const SizedBox(width: 15),
            IconButton(
              onPressed: _addPronoOverlay,
              icon: const Icon(Icons.bento),
            ),
          ],
        ),
      ),
    );
  }
}
