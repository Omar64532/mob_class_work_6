// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyAaf7TgZFFKLkNrnFmWQF4Vc-0p3BgUx3E',
    appId: '1:466561001817:web:f2453d4bcfc60521520448',
    messagingSenderId: '466561001817',
    projectId: 'mobcw6',
    authDomain: 'mobcw6.firebaseapp.com',
    storageBucket: 'mobcw6.firebasestorage.app',
    measurementId: 'G-G4HPC40RT0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR4dz5rhzF3CV-YYLMXZ75IlhVBiUtDo8',
    appId: '1:466561001817:android:bd201b91c57de90f520448',
    messagingSenderId: '466561001817',
    projectId: 'mobcw6',
    storageBucket: 'mobcw6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAF5sfKf3Bhb4kv6C0wgQUTeUlYO5Sj7Xo',
    appId: '1:466561001817:ios:294a9fb96d75a174520448',
    messagingSenderId: '466561001817',
    projectId: 'mobcw6',
    storageBucket: 'mobcw6.firebasestorage.app',
    iosBundleId: 'com.example.mobClassWork6',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAF5sfKf3Bhb4kv6C0wgQUTeUlYO5Sj7Xo',
    appId: '1:466561001817:ios:294a9fb96d75a174520448',
    messagingSenderId: '466561001817',
    projectId: 'mobcw6',
    storageBucket: 'mobcw6.firebasestorage.app',
    iosBundleId: 'com.example.mobClassWork6',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAaf7TgZFFKLkNrnFmWQF4Vc-0p3BgUx3E',
    appId: '1:466561001817:web:1f297e16c5881c4c520448',
    messagingSenderId: '466561001817',
    projectId: 'mobcw6',
    authDomain: 'mobcw6.firebaseapp.com',
    storageBucket: 'mobcw6.firebasestorage.app',
    measurementId: 'G-5X71WR6Z39',
  );
}
