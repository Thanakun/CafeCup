import "package:flutter/material.dart";
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/Splashscreen.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/screen/shop_register/shop_register_first_view.dart';
import 'package:flutter_application_1/screen/shop_register/shop_register_second_view.dart';
import 'package:flutter_application_1/utility/routes/routes.dart';
import 'package:flutter_application_1/utility/routes/routes_name.dart';

void main() async {
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
    return const MaterialApp(
        title: 'Flutter Demo',
        // color: Color.fromRGBO(0, 0, 0, 1),
        // theme: ThemeData(
        //     primarySwatch: Color.fromARGB(0, 0, 0, 255)),
        // initialRoute: RoutesName.splash,
        // onGenerateRoute: Routes.generateRoute,
        home: RegisterPage());
  }
}
