import 'dart:core';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pronolol/data/players_data.dart';
import 'package:pronolol/models/match_model.dart';
import 'package:pronolol/models/player_model.dart';
import 'package:pronolol/models/user_model.dart';

class FirebaseApi {
  static const pronololPath = "test";
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Match> sortedNeedingBetMatchesByDateDesc = [];
  static List<Match> sortedMatchesByDateDesc = [];
  static List<Match> futureMatches = [];
  static List<Match> pastOrPredictedMatches = [];
  static List<Match> predictionsPully =
      []; //=> une List<List<Match>> avec tous les joueurs ? ou on garde une liste/joueur
  static List<Player> playersRanking = getPlayersRanking();

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

      pastOrPredictedMatches =
          docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> predict(String id, int score1, int score2) async {
    await _firebaseFirestore.collection(pronololPath).doc(id).set({
      'predictions${User.name}': [score1, score2]
    }, SetOptions(merge: true));
  }

  static Future<void> getPlayersPredictions() async {
    try {
      final docRefs = await _firebaseFirestore
          .collection(pronololPath)
          .where("predictionsPully")
          .orderBy("date", descending: true)
          .get();

      predictionsPully =
          docRefs.docs.map((e) => Match.fromFirebase(e.id, e.data())).toList();
    } catch (e) {
      log(e.toString());
    }
  }

  static List<Player> getPlayersRanking() {
    List<Player> result = playersData.keys.toList();
    result.sort(((player1, player2) => player1.rank.compareTo(player2.rank)));
    return result;
  }
}
