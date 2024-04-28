import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/utils/tournaments.dart';

class InscriptionModal extends StatefulWidget {
  final String pin;

  const InscriptionModal(this.pin, {super.key});

  @override
  State<InscriptionModal> createState() => _InscriptionModalState();
}

class _InscriptionModalState extends State<InscriptionModal> {
  String userName = '', userEmoji = '';

  void _changeUserEmoji(String emoji) {
    setState(() {
      userEmoji = emoji;
    });
  }

  void _changeUserName(String name) {
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choisis un Nom pour ton profil'),
                  onSubmitted: _changeUserName),
              TextField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choisis un Nom pour ton profil'),
                  onSubmitted: _changeUserEmoji),
              IconButton(
                  onPressed: () async {
                    await PostgresApi.updateUser(widget.pin, userName);
                    if (context.mounted) {}
                  },
                  icon: const Icon(Icons.check)),
            ],
          ),
        ),
      ),
    );
  }
}
