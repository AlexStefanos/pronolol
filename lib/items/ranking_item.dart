import 'package:flutter/material.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/utils/colors.dart';

class RankingItem extends StatelessWidget {
  final User user;
  final num score;
  final int rank;

  const RankingItem(this.user, this.score, this.rank, {super.key});

  Color? getRankColor() {
    if (rank == 1) {
      return appColors['WIN'];
    } else if (rank == 6) {
      return appColors['LOSE'];
    } else {
      return appColors['PREDICTED'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: getRankColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Column(
            children: [
              Text(
                '#$rank ${user.name}${user.emoji} - $score points',
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
