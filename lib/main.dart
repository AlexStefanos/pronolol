import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pronolol/api/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi.initNotifications();
  await User.getUser();
  await FirebaseApi.getLogos();
  initializeDateFormatting('fr_FR');
  runApp(const PronololApp());
}

class PronololApp extends StatelessWidget {
  const PronololApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      themeMode: ThemeMode.dark,
    );
  }
}
