import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pronolol/player_prono_item.dart';

class PlayerProno extends StatefulWidget {
  final String user;

  const PlayerProno(this.user, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayerPronoState();
  }
}

class _PlayerPronoState extends State<PlayerProno> {
  final Map<String, List<dynamic>> pronos = {};
  final Map<String, List<dynamic>> teams = {};

  @override
  Widget build(BuildContext context) {
    void getClientStream() async {
      var collectionRef = FirebaseFirestore.instance.collection('pronostics');
      QuerySnapshot querySnapshot = await collectionRef.get();
      // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      collectionRef.get().then((QuerySnapshot qS) {
        for (var doc in qS.docs) {
          int i = 0;
          if (doc['name'] == widget.user) {
            setState(() {
              pronos[doc['name'] + i.toString()] = doc['pronos'];
              teams[doc['name'] + i.toString()] = doc['teams'];
            });
          }
        }
      });
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          IconButton(
            onPressed: getClientStream,
            icon: const Icon(Icons.refresh),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pronos.length + teams.length,
              itemBuilder: (ctx, i) => PlayerPronoItem(pronos, teams, i),
            ),
          ),
        ],
      ),
    );
  }
}
