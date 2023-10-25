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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              LolEsportApi.matches[index].teamA.imageUrl,
              height: 50,
              width: 50,
              alignment: Alignment.centerLeft,
            ),
            Text(LolEsportApi.matches[index].toString()),
            Image.network(
              LolEsportApi.matches[index].teamB.imageUrl,
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
