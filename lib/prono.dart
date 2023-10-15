import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pronolol/api/lolesport.dart';

class Prono extends StatefulWidget {
  final int index;

  const Prono(this.index, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PronoState();
  }
}

class _PronoState extends State<Prono> {
  var _dropDownValue1 = 0;
  var _dropDownValue2 = 0;

  @override
  Widget build(BuildContext context) {
    void _sendProno() {
      FirebaseFirestore.instance.collection('pronostics').doc('match_00').set({
        'player1': [_dropDownValue1, _dropDownValue2]
      });
    }

    void dropDownCallback1(int? selectedValue) {
      if (selectedValue is int) {
        setState(() {
          _dropDownValue1 = selectedValue;
        });
      }
    }

    void dropDownCallback2(int? selectedValue) {
      if (selectedValue is int) {
        setState(() {
          _dropDownValue2 = selectedValue;
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.network(
            LolEsportApi.previousMatches[widget.index].teamA.imageUrl,
            height: 50,
            width: 50,
          ),
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('0'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('1'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('2'),
              ),
            ],
            value: _dropDownValue1,
            onChanged: dropDownCallback1,
          ),
          const SizedBox(width: 50),
          Image.network(
            LolEsportApi.previousMatches[widget.index].teamB.imageUrl,
            height: 50,
            width: 50,
          ),
          DropdownButton(
            items: const [
              DropdownMenuItem(
                value: 0,
                child: Text('0'),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('1'),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('2'),
              ),
            ],
            value: _dropDownValue2,
            onChanged: dropDownCallback2,
          ),
          IconButton(
            onPressed: _sendProno,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
