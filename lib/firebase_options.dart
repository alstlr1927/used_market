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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA1mPTHN5y9GT9hqBPmasPyZBveTZpfwFA',
    appId: '1:422219287846:android:ae4438fb79a7e3aa1985e7',
    messagingSenderId: '422219287846',
    projectId: 'usedmarket-21905',
    storageBucket: 'usedmarket-21905.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDCvgLUbxaanVN-gSkxhzAAXoFocb9rYTs',
    appId: '1:422219287846:ios:3bce2eb6d96b12521985e7',
    messagingSenderId: '422219287846',
    projectId: 'usedmarket-21905',
    storageBucket: 'usedmarket-21905.appspot.com',
    iosClientId: '422219287846-re55acf1atj8tmpa6ma48dhl0jtdulq5.apps.googleusercontent.com',
    iosBundleId: 'com.hswoo.usedmarket',
  );
}
