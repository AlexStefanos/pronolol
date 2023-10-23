import 'package:flutter/material.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:pronolol/prono.dart';

class MatchItem extends StatelessWidget {
  final int index;
  final String user;

  const MatchItem(this.index, this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    void addPronoOverlay() {
      showModalBottomSheet(
        context: context,
        builder: (ctx) => Prono(index, user),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            Image.network(
              LolEsportApi.previousMatches[index].teamA.imageUrl,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            Text(LolEsportApi.previousMatches[index].toString()),
            const SizedBox(width: 10),
            Image.network(
              LolEsportApi.previousMatches[index].teamB.imageUrl,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 45),
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
