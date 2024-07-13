import 'package:flutter/material.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/pages/ranking_page.dart';
import 'package:pronolol/utils/tournaments.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: const Text(
              '🚧',
              style: TextStyle(fontSize: 35),
            ),
            title: const Text('Pickem\'s (Pas encore fini)'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.global))))
            },
          ),
          ListTile(
            leading:
                Image.asset('assets/Planet_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - Global'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.global))))
            },
          ),
          ListTile(
            leading:
                Image.asset('assets/Planet_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - Global'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      const RankingPage(Tournaments.global))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LEC_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - LEC'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.lec))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LEC_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - LEC'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lec))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LCK_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - LCK'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.lck))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LCK_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - LCK'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lck))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LPL_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - LPL'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.lpl))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LPL_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - LPL'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lpl))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/MSI_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - MSI'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.msi))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/MSI_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - MSI'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.msi))))
            },
          ),
          ListTile(
            leading:
                Image.asset('assets/Worlds_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - Global'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.worlds))))
            },
          ),
          ListTile(
            leading:
                Image.asset('assets/Worlds_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - Worlds'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) =>
                      const RankingPage(Tournaments.worlds))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LFL_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - LFL'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.lfl))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/LFL_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - LFL'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.lfl))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/EUM_logo.png', height: 40, width: 40),
            title: const Text('Prédictions - EUM'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const HomePage(Tournaments.eum))))
            },
          ),
          ListTile(
            leading: Image.asset('assets/EUM_logo.png', height: 40, width: 40),
            title: const Text('Classement Prédictions - EUM'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const RankingPage(Tournaments.eum))))
            },
          ),
        ],
      ),
    );
  }
}
