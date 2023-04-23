import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
// import 'package:get/get.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? final_username;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getValidationData().whenComplete(
      () => {
        Timer(
            Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => final_username == null ? login() : HomeScreen()))),
      },
    );
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtained_username = sharedPreferences.getString('username');
    setState(() {
      final_username = obtained_username!;
    });
    print(final_username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              child: Icon(Icons.local_dining),
              radius: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
