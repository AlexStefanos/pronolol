import 'package:flutter/material.dart';
import 'package:pronolol/data/players_data.dart';
import 'package:pronolol/models/player_model.dart';

class PlayerItem extends StatelessWidget {
  final Player player;
  final int rank;

  const PlayerItem(this.player, this.rank, {super.key});

  Color getPlayerColor() {
    if (rank == 0) {
      return (const Color.fromARGB(172, 49, 189, 84));
    } else if (rank == 5) {
      return (const Color.fromARGB(146, 173, 0, 0));
    } else {
      return (const Color.fromARGB(120, 96, 125, 139));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: getPlayerColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Column(
            children: [
              Text(
                '${player.name} ${playersData[player.name]!}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text('${player.score} (${rank + 1}/6)'),
            ],
          ),
        ),
      ),
    );
  }
}
