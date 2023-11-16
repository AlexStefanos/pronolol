import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:pronolol/data/teams_data.dart';

class MatchApi {
  Match match;
  Map<String, String> bets = {};

  MatchApi(this.match, this.bets);
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<MatchApi> matches = [];

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  static Future<void> fetchAllMatches() async {
    FirebaseApi.matches = (await _firebaseFirestore
            .collection('pronolol')
            .get())
        .docs
        .map((doc) => MatchApi(
              Match(
                Team(
                    doc.data()['designation'].split('-')[0],
                    teamsLogo[doc.data()['designation'].split('-')[0] ?? ''] ??
                        ''),
                Team(
                    doc.data()['designation'].split('-')[1],
                    teamsLogo[doc.data()['designation'].split('-')[1] ?? ''] ??
                        ''),
                doc.data()['bo'] ?? 0,
                scoreA: int.parse(doc.data()['result'][0]),
                scoreB: int.parse(doc.data()['result'][1]),
              ),
              doc.data()['bets'] ?? {},
            ))
        .toList();
  }

  static Future<void> updateDbMatches() async {
    final pronololRef = _firebaseFirestore.collection('pronolol');
    for (int i = 0; i < LolEsportApi.matches.length; i++) {
      final match = LolEsportApi.matches[i];
      if (match.teamA.name == "TBD" || match.teamB.name == "TBD") {
        continue;
      }

      final queryMatch = await pronololRef
          .where(Filter.and(
              Filter("designation", isEqualTo: match.designation()),
              Filter("bo", isEqualTo: match.bo)))
          .get();

      if (queryMatch.size == 0) {
        await pronololRef.add({
          "designation": match.designation(),
          "result": match.score(),
          "bo": match.bo
        });
      }

      if (queryMatch.size == 1 &&
          queryMatch.docs[0].data()['result'] != match.score()) {
        await pronololRef
            .doc(queryMatch.docs[0].id)
            .set({"result": match.score()}, SetOptions(merge: true));
      }
    }
  }
}
