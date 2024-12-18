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
    apiKey: 'AIzaSyCN2-jNFoyTb51gSYNKIOwg4nKMhPadfik',
    appId: '1:512245206475:web:cc3f324dd4892d5750ba4e',
    messagingSenderId: '512245206475',
    projectId: 'flutterloginusers',
    authDomain: 'flutterloginusers.firebaseapp.com',
    storageBucket: 'flutterloginusers.firebasestorage.app',
    measurementId: 'G-LCRVHLYC05',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBnKjHBua3NxcfWLOh2Rspyg96HNgiAu6k',
    appId: '1:512245206475:android:fa5bfa6e28665e9e50ba4e',
    messagingSenderId: '512245206475',
    projectId: 'flutterloginusers',
    storageBucket: 'flutterloginusers.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCB1WnO7hE6eZrM7x7x2ZJKbJ4C1pmztEg',
    appId: '1:512245206475:ios:4fb53d8a138fb60d50ba4e',
    messagingSenderId: '512245206475',
    projectId: 'flutterloginusers',
    storageBucket: 'flutterloginusers.firebasestorage.app',
    iosClientId: '512245206475-q93kpo1l3duvksm33r0fgkj7cu2e8g51.apps.googleusercontent.com',
    iosBundleId: 'com.example.iseneca',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB0xEYXvQOtsEYB3XRrru7L67diWXbOroc',
    appId: '1:364563782587:ios:b90321f01908c5cf70829e',
    messagingSenderId: '364563782587',
    projectId: 'isenecafirebase-4a37f',
    storageBucket: 'isenecafirebase-4a37f.appspot.com',
    androidClientId: '364563782587-8cgsee9ttfpl7s7rh43tfmqlvoi7mjru.apps.googleusercontent.com',
    iosClientId: '364563782587-lavsm6d2oe27nqbf2r7h1rgokmcrnp13.apps.googleusercontent.com',
    iosBundleId: 'com.example.iseneca.RunnerTests',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCN2-jNFoyTb51gSYNKIOwg4nKMhPadfik',
    appId: '1:512245206475:web:71ad6098a1a4e15050ba4e',
    messagingSenderId: '512245206475',
    projectId: 'flutterloginusers',
    authDomain: 'flutterloginusers.firebaseapp.com',
    storageBucket: 'flutterloginusers.firebasestorage.app',
    measurementId: 'G-2XFF5C5ZD0',
  );

}