import 'package:flutter/material.dart';
import 'package:pronolol/match_item.dart';
import 'package:pronolol/data/matches_data.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchPageState();
  }
}

class _MatchPageState extends State<Matches> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pronolol'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: matches.length,
              itemBuilder: (ctx, i) => MatchItem(matches[i]),
            ),
          ),
        ],
      ),
    );
  }
}
