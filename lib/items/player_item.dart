import 'package:flutter/material.dart';
import 'package:pronolol/data/players_data.dart';
import 'package:pronolol/models/player_model.dart';

class PlayerItem extends StatelessWidget {
  final Player player;

  const PlayerItem(this.player, {super.key});

  MaterialColor getPlayerColor() {
    if (player.rank == 1) {
      return (Colors.green);
    } else if (player.rank == 6) {
      return (Colors.red);
    } else {
      return (Colors.grey);
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
                '${player.name} ${playersData[player]!}',
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(height: 5),
              Text('${player.score} (${player.rank}/6)'),
            ],
          ),
        ),
      ),
    );
  }
}
