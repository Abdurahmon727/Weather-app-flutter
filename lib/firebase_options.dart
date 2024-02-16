// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import "package:firebase_core/firebase_core.dart" show FirebaseOptions;
import "package:flutter/foundation.dart"
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
        "DefaultFirebaseOptions have not been configured for web - "
        "you can reconfigure this by running the FlutterFire CLI again.",
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          "DefaultFirebaseOptions have not been configured for macos - "
          "you can reconfigure this by running the FlutterFire CLI again.",
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          "DefaultFirebaseOptions have not been configured for windows - "
          "you can reconfigure this by running the FlutterFire CLI again.",
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          "DefaultFirebaseOptions have not been configured for linux - "
          "you can reconfigure this by running the FlutterFire CLI again.",
        );
      default:
        throw UnsupportedError(
          "DefaultFirebaseOptions are not supported for this platform.",
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDZLwEw3MfQSgUOrpRRkxdYFPHOvbNUMJY",
    appId: "1:565463368310:android:b87d11e24be95281f75557",
    messagingSenderId: "565463368310",
    projectId: "sample-bloc-5b8b9",
    storageBucket: "sample-bloc-5b8b9.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyAPCPZWfOLCPf4NfuniTQ1MqVMFsT0xXkc",
    appId: "1:565463368310:ios:6f165dd5dde1c2d6f75557",
    messagingSenderId: "565463368310",
    projectId: "sample-bloc-5b8b9",
    storageBucket: "sample-bloc-5b8b9.appspot.com",
    iosBundleId: "uz.udevs.cleanArchitecture",
  );
}
