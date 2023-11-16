import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/match_item.dart';

class Bet extends StatefulWidget {
  const Bet({super.key});

  @override
  State<Bet> createState() => _BetState();
}

class _BetState extends State<Bet> {
  @override
  Widget build(BuildContext context) {
    final matchesNeedingABet = FirebaseApi.matches
        .map((matchApi) => matchApi.match)
        .where((match) => match.score() == "00");

    return ListView.builder(
        itemCount: matchesNeedingABet.length,
        itemBuilder: (ctx, i) =>
            MatchItem(matchesNeedingABet.elementAt(i), "Caribou"));
  }
}
