import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/user_model.dart';

class FirebaseApi {
  static const pronololPath = 'pronolol';
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Match> futureMatches = [];
  static List<Match> pastMatches = [];
  static List<Match> predictedMatches = [];
  static List<Match> playerPredictions = [];
  static Map<String, dynamic> logos = {};

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  static Future<void> getFutureMatches() async {
    try {
      final docRefs = await _firebaseFirestore
          .collection(pronololPath)
          .where('date', isGreaterThanOrEqualTo: DateTime.now())
          .where('date',
              isLessThan: DateTime.now().add(const Duration(days: 7)))
          .orderBy('date')
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
          .where('date', isLessThan: DateTime.now())
          .orderBy('date', descending: true)
          .get();

      pastMatches =
          docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getPredictedMatches() async {
    try {
      List<Match> tmp = pastMatches + futureMatches;
      playerPredictions =
          tmp.where((e) => e.predictions.containsKey(User.name)).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> predict(String id, String score) async {
    await _firebaseFirestore.collection(pronololPath).doc(id).set({
      'predictions': {User.name: score}
    }, SetOptions(merge: true));
  }

  static Future<void> getLogos() async {
    logos =
        (await _firebaseFirestore.collection('pronolol_data').doc('logo').get())
            .data()!;
  }
}
