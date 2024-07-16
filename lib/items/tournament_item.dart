import 'package:flutter/material.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/pages/ranking_page.dart';
import 'package:pronolol/utils/tournaments.dart';

class TournamentItem extends StatelessWidget {
  final String name, logo;

  const TournamentItem(this.name, this.logo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Image.network(logo, width: 45, height: 45),
            title: Text('Prédictions $name'),
            onTap: () {
              if (name == 'LEC') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.lec))));
              } else if (name == 'LCK') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.lck))));
              } else if (name == 'LPL') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.lpl))));
              } else if (name == 'MSI') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.msi))));
              } else if (name == 'WORLDS') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        const HomePage(Tournaments.worlds))));
              } else if (name == 'ESWC') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.eswc))));
              } else if (name == 'LFL') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.lfl))));
              } else if (name == 'EUM') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const HomePage(Tournaments.eum))));
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) =>
                        const HomePage(Tournaments.global))));
              }
            }),
        ListTile(
          leading: Image.network(logo, width: 45, height: 45),
          title: Text('Classement Prédictions $name'),
          onTap: () {
            if (name == 'LEC') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lec))));
            } else if (name == 'LCK') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lck))));
            } else if (name == 'LPL') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lpl))));
            } else if (name == 'MSI') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.msi))));
            } else if (name == 'WORLDS') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      const RankingPage(Tournaments.worlds))));
            } else if (name == 'LFL') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lfl))));
            } else if (name == 'EUM') {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.eum))));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      const RankingPage(Tournaments.global))));
            }
          },
        ),
      ],
    );
  }
}
