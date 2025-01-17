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
    apiKey: 'AIzaSyAGXPpbAgp-j5dgnxkaDHdc4-hSQKYLIO8',
    appId: '1:527047135966:web:d59ecd6a5ba9996913284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    authDomain: 'biteproof-13317.firebaseapp.com',
    storageBucket: 'biteproof-13317.appspot.com',
    measurementId: 'G-NJMJYTW91L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBT1sJ3lKarBmo_LRghtaCAHvPgew3dwQU',
    appId: '1:527047135966:android:749a52e754f6afb813284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    storageBucket: 'biteproof-13317.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCV9DIJlpzrViashOtjL-KXFI38rucLxXE',
    appId: '1:527047135966:ios:c49028abb1e91ac013284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    storageBucket: 'biteproof-13317.appspot.com',
    iosBundleId: 'com.example.biteproof',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCV9DIJlpzrViashOtjL-KXFI38rucLxXE',
    appId: '1:527047135966:ios:c49028abb1e91ac013284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    storageBucket: 'biteproof-13317.appspot.com',
    iosBundleId: 'com.example.biteproof',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAGXPpbAgp-j5dgnxkaDHdc4-hSQKYLIO8',
    appId: '1:527047135966:web:f1a39ef0e022292413284f',
    messagingSenderId: '527047135966',
    projectId: 'biteproof-13317',
    authDomain: 'biteproof-13317.firebaseapp.com',
    storageBucket: 'biteproof-13317.appspot.com',
    measurementId: 'G-36LXTEHGQ2',
  );
}
