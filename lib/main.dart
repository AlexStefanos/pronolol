import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pronolol/matches.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi.initNotifications();
  await LolEsportApi.getWebsiteData();
  await FirebaseApi.getAllUsersBets();
  int total = 0;
  final userBets =
      FirebaseApi.bets.where((data) => data['bets'].keys.contains('Tristan'));
  for (Map<String, dynamic> userBet in userBets) {
    if (userBet['bets']['Caribou'] == userBet['result']) {
      total += 2;
    }
  }
  log(total.toString());
  runApp(const PronololApp());
}

class PronololApp extends StatelessWidget {
  const PronololApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Matches(),
    );
  }
}
