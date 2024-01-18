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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD282nYoWcd1WgBiewn2tHkd73XhBtrfIs',
    appId: '1:473022349727:web:0a609b385eeadec478fdaa',
    messagingSenderId: '473022349727',
    projectId: 'final-major-project-e1afe',
    authDomain: 'final-major-project-e1afe.firebaseapp.com',
    storageBucket: 'final-major-project-e1afe.appspot.com',
    measurementId: 'G-PKE0HMCZ9T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7S_aJ79MnKhyQy7eIbebqphw1GjD4NDg',
    appId: '1:473022349727:android:683c9e054a95566678fdaa',
    messagingSenderId: '473022349727',
    projectId: 'final-major-project-e1afe',
    storageBucket: 'final-major-project-e1afe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYxVGQDNwqkqkMFrisyK_tyNAtx4gaFJ4',
    appId: '1:473022349727:ios:1e06ac00cd83d1e978fdaa',
    messagingSenderId: '473022349727',
    projectId: 'final-major-project-e1afe',
    storageBucket: 'final-major-project-e1afe.appspot.com',
    iosBundleId: 'com.example.finalMajorProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAYxVGQDNwqkqkMFrisyK_tyNAtx4gaFJ4',
    appId: '1:473022349727:ios:54dd3dff90f167e978fdaa',
    messagingSenderId: '473022349727',
    projectId: 'final-major-project-e1afe',
    storageBucket: 'final-major-project-e1afe.appspot.com',
    iosBundleId: 'com.example.finalMajorProject.RunnerTests',
  );
}