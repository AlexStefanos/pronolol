import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pronolol/api/lolesport.dart';

class Prono extends StatefulWidget {
  final int index;
  final String user;

  const Prono(this.index, this.user, {super.key});

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
    Future<bool> matchExistence() async {
      bool result = false;
      var collectionRef = FirebaseFirestore.instance.collection('pronostics');
      collectionRef.get().then((QuerySnapshot qS) {
        for (var doc in qS.docs) {
          if (doc['teams'] ==
              [
                LolEsportApi.previousMatches[widget.index].team1.name,
                LolEsportApi.previousMatches[widget.index].team2.name
              ]) {
            result = true;
          }
        }
      });
      return result;
    }

    void sendProno() async {
      var collectionRef = FirebaseFirestore.instance.collection('pronostics');
      if ((widget.user != '-') && (await matchExistence() == false)) {
        collectionRef.doc().set({
          'teams': [
            LolEsportApi.previousMatches[widget.index].team1.name,
            LolEsportApi.previousMatches[widget.index].team2.name
          ],
          'pronos${widget.user}': [_dropDownValue1, _dropDownValue2]
        });
      } else {
        collectionRef.get().then((QuerySnapshot qS) {
          for (var doc in qS.docs) {
            if (doc['teams'] ==
                [
                  LolEsportApi.previousMatches[widget.index].team1.name,
                  LolEsportApi.previousMatches[widget.index].team2.name
                ]) {
              collectionRef.doc(doc.id).set({
                'pronos${widget.user}': [_dropDownValue1, _dropDownValue2]
              });
            }
          }
        });
      }
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
            LolEsportApi.previousMatches[widget.index].team1.imageUrl,
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
            LolEsportApi.previousMatches[widget.index].team2.imageUrl,
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
            onPressed: (_dropDownValue1 != _dropDownValue2)
                ? sendProno
                : () {/*TODO*/},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
