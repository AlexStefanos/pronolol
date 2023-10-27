import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/api/lolesport.dart';

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Map<String, dynamic>> bets = [];

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  static Future<void> getAllUsersBets() async {
    FirebaseApi.bets = (await _firebaseFirestore.collection('pronolol').get())
        .docs
        .map((doc) => doc.data())
        .toList();
  }

  static Future<void> addNewMatches() async {
    for (int i = 0; i < LolEsportApi.matches.length; i++) {
      final match = LolEsportApi.matches[i];
      if (match.teamA.name == "TBD" || match.teamB.name == "TBD") {
        continue;
      }

      if ((await _firebaseFirestore
                  .collection('pronolol')
                  .where("designation", isEqualTo: match.designation())
                  .get())
              .size ==
          0) {
        await _firebaseFirestore.collection('pronolol').add({
          "designation": match.designation(),
          "result ": match.score(),
        });
      }
    }
  }
}
