import 'package:flutter/material.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:pronolol/leaderboard.dart';
import 'package:pronolol/match_item.dart';
import 'package:pronolol/player_pronos.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchPageState();
  }
}

class _MatchPageState extends State<Matches> {
  String user = '-';

  void changeUser(String? selectedValue) {
    String cleanValue = selectedValue.toString();
    setState(() {
      user = cleanValue;
    });
  }

  void seePlayerPronos() {
    showModalBottomSheet(context: context, builder: (ctx) => PlayerProno(user));
  }

  void seeLeaderboard() {
    showModalBottomSheet(context: context, builder: (ctx) => const Leaderboard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pronolol'),
        actions: [
          ElevatedButton(
            onPressed: seePlayerPronos,
            child: const Text('Mes pronos'),
          ),
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: '-',
                child: Text('-'),
              ),
              DropdownMenuItem(
                value: 'Caribou',
                child: Text('Caribou'),
              ),
              DropdownMenuItem(
                value: 'Tristan',
                child: Text('Tristan'),
              ),
              DropdownMenuItem(
                value: 'Nathan',
                child: Text('Nathan'),
              ),
              DropdownMenuItem(
                value: 'Quentin',
                child: Text('Quentin'),
              ),
              DropdownMenuItem(
                value: 'Charles',
                child: Text('Charles'),
              ),
              DropdownMenuItem(
                value: 'Alex',
                child: Text('Alex'),
              ),
            ],
            value: user,
            onChanged: changeUser,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: LolEsportApi.matches.length,
              itemBuilder: (ctx, i) => MatchItem(i, user),
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () => seeLeaderboard()),
    );
  }
}
