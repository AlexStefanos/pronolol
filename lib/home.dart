import 'package:flutter/material.dart';
import 'package:pronolol/matches_list.dart';
import 'package:pronolol/models/match.dart';
import 'package:pronolol/data/teams.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final List<Match> _matchesList = [
    Match(teams[0], teams[1], ["BO3", "Worlds"], DateTime.now(), true)
  ];

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('Y a pu de matchs igo tu fous quoi ?'));

    if (_matchesList.isNotEmpty) {
      mainContent = ListView.builder(
          itemCount: _matchesList.length,
          itemBuilder: (ctx, i) =>
              Dismissible(key: ValueKey(_matchesList), child: _matchesList[i]));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("pronolol"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
