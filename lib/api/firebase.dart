import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/team_model.dart';

class FirebaseApi {
  static const pronololPath = "pronolol";
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Match> sortedMatchesByDateDesc = [];
  static List<Match> sortedBetMatchesByDateDesc = [];

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  // Fetch matches that dont have a score in firebase and sort them by date
  static Future<void> fetchLastMatches(int limit) async {
    final docRefs = await _firebaseFirestore
        .collection(pronololPath)
        .orderBy("date", descending: true)
        .limit(limit)
        .get();
    sortedMatchesByDateDesc =
        docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
  }

  static Future<void> fetchNextMatches() async {
    /* final docRefs = await _firebaseFirestore
        .collection(pronololPath)
        .where(Filter.and(Filter("team1.score", isEqualTo: 0),
            Filter("team2.score", isEqualTo: 0)))
        .orderBy("date", descending: true)
        .get(); */
    sortedBetMatchesByDateDesc = [];
//        docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
  }

  // TODO: Add user name
  static Future<void> bet(
      String id, String user, int score1, int score2) async {
    await _firebaseFirestore.collection(pronololPath).doc(id).set({
      "hasBet": [user],
      user: [score1, score2]
    }, SetOptions(merge: true));
  }
}
