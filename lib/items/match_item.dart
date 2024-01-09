import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/modals/bet_modal.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/user_model.dart';

class MatchItem extends StatefulWidget {
  final Match match;

  const MatchItem(this.match, {super.key});

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  void openMatchPage() {}

  void showBetModal(BuildContext ctx) async {
    var value = await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return BetModal(widget.match);
        });
    setState(() {
      if (value != null) {
        widget.match.predictions[User.name ?? ''] = value;
      }
    });
  }

  Color getMatchColor() {
    if (!widget.match.isFutureMatch()) {
      if (widget.match.hasPredicted(User.name ?? '')) {
        if (widget.match.hasPerfectWin(User.name ?? '')) {
          return const Color(0xFFEBB22F);
        } else if (widget.match.hasWin(User.name ?? '')) {
          return const Color(0xFF31BD55);
        } else {
          return const Color(0xFFEB4829);
        }
      } else {
        return const Color.fromARGB(120, 96, 125, 139);
      }
    } else {
      if (widget.match.canPredict(User.name ?? '')) {
        return const Color(0xFF318CE7);
      } else {
        return const Color.fromARGB(120, 96, 125, 139);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => (((widget.match.isFutureMatch()) &&
                  (!widget.match.canPredict(User.name ?? ''))) ||
              !widget.match.isFutureMatch())
          ? openMatchPage()
          : showBetModal(context),
      child: Card(
        color: getMatchColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                FirebaseApi.logos[widget.match.team1.name]!,
                height: 50,
                width: 50,
                alignment: Alignment.centerLeft,
              ),
              widget.match.hasPredicted(User.name ?? '')
                  ? Text(
                      widget.match.toStringFromUserPrediction(User.name ?? ''))
                  : Text(widget.match.toString()),
              Image.network(
                FirebaseApi.logos[widget.match.team2.name]!,
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
