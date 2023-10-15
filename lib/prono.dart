import 'package:flutter/material.dart';

class Prono extends StatefulWidget {
  const Prono({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PronoState();
  }
}

class _PronoState extends State<Prono> {
  final _team1Controller = TextEditingController();
  final _team2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _team1Controller,
            // onChanged: ,
            maxLength: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Team 1'),
            ),
          ),
          TextField(
            controller: _team2Controller,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: const InputDecoration(
              label: Text('Team 2'),
            ),
          ),
        ],
      ),
    );
  }
}
