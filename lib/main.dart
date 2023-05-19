import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/Splashscreen.dart';
// import 'package:flutter_application_1/screen/my_component/select_month_week_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/model/check_login.dart';
// import 'screen/home.dart';
// import 'screen/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
