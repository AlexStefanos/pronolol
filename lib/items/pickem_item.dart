import 'package:flutter/material.dart';
import 'package:pronolol/modals/pickems_players_predictions_modal.dart';
import 'package:pronolol/modals/pickems_prediction_modal.dart';
import 'package:pronolol/models/pickem_model.dart';
import 'package:pronolol/utils/colors.dart';

class PickemItem extends StatefulWidget {
  final Pickem pickem;

  const PickemItem(this.pickem, {super.key});

  @override
  State<PickemItem> createState() => _PickemItemState();
}

class _PickemItemState extends State<PickemItem> {
  var _isOpen = false;

  void showBetModal(BuildContext ctx) async {
    var value = await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return PickemsPredictionModal(widget.pickem);
        });
    setState(() {
      if (value != null) {
        widget.pickem.currentUserPrediction = value;
      }
    });
  }

  void showPlayersPredictions(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return PickemPlayersPredictionsModal(widget.pickem);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.pickem.tournament.isFutureTournament) {
          showBetModal(context);
        } else {
          setState(() {
            _isOpen = !_isOpen;
          });
        }
      },
      child: Card(
        color: widget.pickem.tournament.isFutureTournament
            ? widget.pickem.currentUserHasPredicted
                ? appColors['PREDICTED']
                : appColors['FUTURE']
            : appColors['PAST'],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                if (widget.pickem.tournament.isFutureTournament) ...[
                  Text(
                    '   ${widget.pickem.tournament.nameDisplay()}, ${widget.pickem.tournament.numericalDate}',
                    style: const TextStyle(
                        fontSize: 17, fontStyle: FontStyle.italic),
                  ),
                  const Expanded(child: SizedBox(width: 1)),
                ],
              ],
            ),
            /*Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [Text('${widget.pickem.answers}')],
              ),
            ),*/
            Text(widget.pickem.question),
          ],
        ),
      ),
    );
  }
}
