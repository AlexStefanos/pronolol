// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDSGgou1x-E0AbRHWOI5LWzyAoMHLfZiLA',
    appId: '1:729772678052:web:40bf4679651b9d7991ff31',
    messagingSenderId: '729772678052',
    projectId: 'bot-discord-397ae',
    authDomain: 'bot-discord-397ae.firebaseapp.com',
    storageBucket: 'bot-discord-397ae.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJJpNJqcaqhxaV588XUpnbwWAQz4Z4Fiw',
    appId: '1:729772678052:android:3203302229597d3691ff31',
    messagingSenderId: '729772678052',
    projectId: 'bot-discord-397ae',
    storageBucket: 'bot-discord-397ae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2kG7LE0vIuGkfZsLx6eOmBe_aOM605a8',
    appId: '1:729772678052:ios:de682e79e1b3543191ff31',
    messagingSenderId: '729772678052',
    projectId: 'bot-discord-397ae',
    storageBucket: 'bot-discord-397ae.appspot.com',
    iosBundleId: 'com.example.pronolol',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2kG7LE0vIuGkfZsLx6eOmBe_aOM605a8',
    appId: '1:729772678052:ios:9485638937aeb6a491ff31',
    messagingSenderId: '729772678052',
    projectId: 'bot-discord-397ae',
    storageBucket: 'bot-discord-397ae.appspot.com',
    iosBundleId: 'com.example.pronolol.RunnerTests',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA2kG7LE0vIuGkfZsLx6eOmBe_aOM605a8',
    appId: '1:729772678052:android:3203302229597d3691ff31',
    messagingSenderId: '729772678052',
    projectId: 'bot-discord-397ae',
    storageBucket: 'bot-discord-397ae.appspot.com',
  );
}
