import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/data/teams_data.dart';
import 'package:pronolol/models/match_model.dart';

class MatchItem extends StatefulWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {

 DropdownMenu buildDropDownMenu() {
    return const DropdownMenu(dropdownMenuEntries: [
      DropdownMenuEntry(value: 1, label: "1"),
      DropdownMenuEntry(value: 2, label: "2"),
      DropdownMenuEntry(value: 3, label: "3")
    ]);
  }

  void openMatchPage() {}

  void showBetModal(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return Center(
              child: Card(
                  child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Image.network(
                      teamsLogo[match.team1.name]!,
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                    ),
                    Text(match.team1.name),
                    buildDropDownMenu()
                  ]),
                  Column(children: [
                    Image.network(
                      teamsLogo[match.team2.name]!,
                      height: 50,
                      width: 50,
                      alignment: Alignment.centerLeft,
                    ),
                    Text(match.team2.name),
                    buildDropDownMenu()
                  ]),
                ],
              ),
              // TODO: Replace user
              IconButton(
                  onPressed: () async => await FirebaseApi.bet(
                      match.id, "Caribou", , ),
                  icon: const Icon(Icons.send))
            ]),
          )));
        });
  }



   @override
  Widget build(BuildContext context) {
    final int bet1 = 0;
    final int bet2 = 0; 
    return GestureDetector(
      onTap: match.canBet() ? () => showBetModal(context) : openMatchPage,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network(
                teamsLogo[match.team1.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              Text(match.toString()),
              Image.network(
                teamsLogo[match.team2.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchItem extends StatelessWidget {
  

 
 
}
