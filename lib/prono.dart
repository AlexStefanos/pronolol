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
    void sendProno() {
      /*TODO : j'aimerai parcourir les documents de pronostics pour savoir si un document dans la bdd a déjà été créé pour un match ou non.
                    Exemple : Avant de créer un document pour le match PSG-BDS par exemple, on parcourt la bdd pour savoir si il y a un doc qui lui est attribué
              Puis, ce sera aussi pratique pour savoir si quelqu'un a déjà fait ses pronos ou non.*/
      bool result = false;
      var collectionRef = FirebaseFirestore.instance.collection('pronostics');
      // try {
      //   collectionRef.get().then((QuerySnapshot qS) async {
      //     for (var doc in qS.docs) {
      //       DocumentSnapshot snapshot = await FirebaseFirestore.instance
      //           .collection('pronostics')
      //           .doc(doc.id)
      //           .get();
      //       print('before if');
      //       if ('${LolEsportApi.previousMatches[widget.index].team1.name}-${LolEsportApi.previousMatches[widget.index].team2.name}' ==
      //           snapshot.data['designation']) {
      //         result = true;
      //         print('entered if');
      //       }
      //     }
      //   });
      // } catch (e) {
      //   rethrow;
      // }
      if (result == false) {
        if ((widget.user != '-')) {
          collectionRef.doc().set(
            {
              'designation':
                  '${LolEsportApi.previousMatches[widget.index].team1.name}-${LolEsportApi.previousMatches[widget.index].team2.name}',
              'result':
                  '${LolEsportApi.previousMatches[widget.index].scoreA}-${LolEsportApi.previousMatches[widget.index].scoreB}',
              'bets': {widget.user: '$_dropDownValue1$_dropDownValue2'}
            },
          );
        } else {
          collectionRef.get().then((QuerySnapshot qS) {
            for (var doc in qS.docs) {
              if (doc['designation'].toString() ==
                  '${LolEsportApi.previousMatches[widget.index].team1.name}-${LolEsportApi.previousMatches[widget.index].team2.name}') {
                collectionRef.doc(doc.id).update(
                  {
                    'bets': {widget.user: '$_dropDownValue1$_dropDownValue2'}
                  },
                );
              }
            }
          });
        }
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
