import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pronolol/firebase_options.dart';
import 'package:pronolol/models/user_model.dart';
import 'package:pronolol/pages/home_page.dart';
import 'package:pronolol/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  initializeDateFormatting('fr_FR');
  await User.fetchUser();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: User.currentUser != null ? const HomePage() : const LoginPage(),
    );
  }
}
