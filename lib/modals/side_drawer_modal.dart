import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Image(
              image: AssetImage('assets/pronolol.png'),
              width: 100,
              height: 100,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Page d\'accueil'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.assignment_late),
            title: const Text('Prédictions du Classement des Équipes'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.assignment_add),
            title: const Text('Prédiction de la All-Pro Team'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
