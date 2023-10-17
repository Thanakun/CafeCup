import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/Splashscreen.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // // Provide your Firebase configuration options
  // FirebaseOptions firebaseOptions = FirebaseOptions(
  //   apiKey: "YOUR_API_KEY",
  //   authDomain: "YOUR_AUTH_DOMAIN",
  //   projectId: "YOUR_PROJECT_ID",
  //   storageBucket: "YOUR_STORAGE_BUCKET",
  //   messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  //   appId: "YOUR_APP_ID",
  // );

  // // Initialize Firebase with the provided options
  // await Firebase.initializeApp(
  //   name: 'yourAppName', // Provide a unique name for your app
  //   options: firebaseOptions,
  // );

  var app = const MyApp();

  runApp(app);
}

//สร้าง widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // primarySwatch: Colors.pink
          ),
      home: const SplashScreen(),
    );
  }
}
