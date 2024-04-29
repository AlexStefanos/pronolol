import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/utils/tournaments.dart';

class InscriptionModal extends StatefulWidget {
  final String cpin;

  const InscriptionModal(this.cpin, {super.key});

  @override
  State<InscriptionModal> createState() => _InscriptionModalState();
}

class _InscriptionModalState extends State<InscriptionModal> {
  String userName = '', userEmoji = '';
  final _titleController = TextEditingController(),
      _emojiController = TextEditingController();

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

  void _updateUser() {
    _changeUserName(_titleController.text.trim());
    _changeUserEmoji(_emojiController.text.trim());
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choisis un Nom pour ton profil',
                      label: Text('Choisis un Nom pour ton profil')),
                  onSubmitted: _changeUserName),
              const SizedBox(height: 10),
              TextField(
                  controller: _emojiController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Choisis un Emoji pour ton profil',
                      label: Text('Choisis un Emoji pour ton profil')),
                  onSubmitted: _changeUserEmoji),
              IconButton(
                  onPressed: () async {
                    _updateUser();
                    await PostgresApi.createUser(
                        widget.cpin, userName, userEmoji);
                    await User.saveUserPin(widget.cpin);
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const HomePage(Tournaments.global)));
                    }
                  },
                  icon: const Icon(Icons.check)),
            ],
          ),
        ),
      ),
    );
  }
}
