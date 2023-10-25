import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;

  static List<Map<String, dynamic>> bets = [];

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
  }

  static Future<void> getAllUsersBets() async {
    FirebaseApi.bets = (await _firebaseFirestore.collection('pronostics').get())
        .docs
        .map((doc) => doc.data()).toList();
  }
}
