import 'package:flutter/material.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:pronolol/api/lolesport.dart';
import 'package:firebase_core/firebase_core.dart';

import 'pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await LolEsportApi.getWebsiteData();
  runApp(const PronololApp());
}

class PronololApp extends StatelessWidget {
  const PronololApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
