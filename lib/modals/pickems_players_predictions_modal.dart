import 'package:flutter/material.dart';
import 'package:pronolol/api/postgres.dart';
import 'package:pronolol/models/pickem_model.dart';

class PickemPlayersPredictionsModal extends StatefulWidget {
  final Pickem pickem;

  const PickemPlayersPredictionsModal(this.pickem, {super.key});

  @override
  State<PickemPlayersPredictionsModal> createState() =>
      _PickemPlayersPredictionsModalState();
}

class _PickemPlayersPredictionsModalState
    extends State<PickemPlayersPredictionsModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: []),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                future: PostgresApi.getPickemPredictionsById(widget.pickem.id),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 18),
                      child: Column(
                        children: [],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ]),
    ));
  }
}
