import 'package:flutter/material.dart';

class PlayerPronoItem extends StatefulWidget {
  final Map<String, List<dynamic>> pronos;
  final Map<String, List<dynamic>> teams;

  const PlayerPronoItem(this.pronos, this.teams, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayerPronoItemState();
  }
}

class _PlayerPronoItemState extends State<PlayerPronoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.teams.values.toList().elementAt(0).toString()),
            Text(widget.pronos.values.toString()),
          ],
        ),
      ),
    );
  }
}
