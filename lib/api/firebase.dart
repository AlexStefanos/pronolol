import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/models/match_model.dart';

class FirebaseApi {
  static const pronololPath = "test";
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Match> sortedNeedingBetMatchesByDateDesc = [];
  static List<Match> sortedMatchesByDateDesc = [];
  static List<Match> futureMatches = [];
  static List<Match> pastOrPredictedMatches = [];

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  static Future<void> getFutureMatches() async {
    try {
      final docRefs = await _firebaseFirestore
          .collection(pronololPath)
          .where("date", isGreaterThanOrEqualTo: DateTime.now())
          .orderBy("date", descending: true)
          .get();

      futureMatches =
          docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getPastMatches() async {
    try {
      final docRefs = await _firebaseFirestore
          .collection(pronololPath)
          .where("date", isLessThan: DateTime.now())
          .orderBy("date", descending: true)
          .get();

      log(docRefs.toString());
      pastOrPredictedMatches =
          docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  // TODO: Replace Caribou by user name
  static Future<void> fetchNeedingBetMatches() async {
    final docRefs = await _firebaseFirestore
        .collection(pronololPath)
        .where("date", isGreaterThan: DateTime.now())
        .orderBy("date", descending: true)
        .get();
    sortedNeedingBetMatchesByDateDesc =
        docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
  }

  static Future<void> fetchMatches(int limit) async {
    final docRefs = await _firebaseFirestore
        .collection(pronololPath)
        .where("score1", isGreaterThan: 0)
        .limit(limit)
        .get();
    sortedMatchesByDateDesc =
        docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
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
