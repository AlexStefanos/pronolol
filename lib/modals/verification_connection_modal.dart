import 'package:flutter/material.dart';
import 'package:pronolol/modals/inscription_modal.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/utils/tournaments.dart';

class VerificationConnectionModal extends StatefulWidget {
  final String cpin;

  const VerificationConnectionModal(this.cpin, {super.key});

  @override
  State<VerificationConnectionModal> createState() =>
      _VerificationConnectionModalState();
}

class _VerificationConnectionModalState
    extends State<VerificationConnectionModal> {
  String userName = '';
  final _userNameController = TextEditingController();

  void _verificationUserName(String name) {
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
                controller: _userNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                        'Quel est le Nom que tu as choisi pour ton profil',
                    label: Text(
                        'Quel est le Nom que tu as choisi pour ton profil')),
                onSubmitted: _verificationUserName,
                onChanged: (value) => _verificationUserName(value),
              ),
              IconButton(
                  onPressed: () async {
                    String? tmpUserName = await User.getUserName(widget.cpin);
                    if (tmpUserName == userName) {
                      await User.saveUserPin(widget.cpin);
                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                const HomePage(Tournaments.global)));
                      }
                    } else {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InscriptionModal(widget.cpin);
                          });
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
