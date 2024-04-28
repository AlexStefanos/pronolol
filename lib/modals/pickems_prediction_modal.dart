import 'package:flutter/material.dart';
import 'package:pronolol/models/pickem_model.dart';

class PickemsPredictionModal extends StatefulWidget {
  final Pickem pickem;

  const PickemsPredictionModal(this.pickem, {super.key});

  @override
  State<PickemsPredictionModal> createState() => _PickemsPredictionModalState();
}

class _PickemsPredictionModalState extends State<PickemsPredictionModal> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Card(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: []),
    ));
  }
}
