import 'package:flutter/material.dart';

class PlayerPronoItem extends StatefulWidget {
  final Map<String, List<dynamic>> pronos;
  final Map<String, List<dynamic>> teams;
  final int index;

  const PlayerPronoItem(this.pronos, this.teams, this.index, {super.key});

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
            // Text(
            //     '${widget.teams.values.toList().elementAt(widget.index)[0]}  ${widget.pronos.values.toList().elementAt(widget.index)[0]} - ${widget.pronos.values.toList().elementAt(widget.index)[1]}  ${widget.teams.values.toList().elementAt(widget.index)[1]}'),
            Text(
                '${widget.teams.values.elementAt(0)[0]}  ${widget.pronos.values.elementAt(0)[0]} - ${widget.pronos.values.elementAt(0)[1]}  ${widget.teams.values.elementAt(0)[1]}'),
          ],
        ),
      ),
    );
  }
}
