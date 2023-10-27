import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  var i = 0;

  @override
  Widget build(BuildContext context) {
    void getClientStream() async {
      var collectionRef = FirebaseFirestore.instance.collection('pronolol');
      collectionRef.get().then((QuerySnapshot qS) {
        for (var doc in qS.docs) {
          if (doc['name'] == widget.user) {
            setState(() {
              pronos[doc['name'] + i.toString()] = doc['pronos'];
              teams[doc['name'] + i.toString()] = doc['teams'];
              i++;
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
              itemCount: pronos.length,
              itemBuilder: (ctx, i) => Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          '${teams.values.elementAt(i)[0]}  ${pronos.values.elementAt(i)[0]} - ${pronos.values.elementAt(i)[1]}  ${teams.values.elementAt(i)[1]}'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
