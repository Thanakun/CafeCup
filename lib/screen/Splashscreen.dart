import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
// import 'package:get/get.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_application_1/screen/shop_register/shop_register_first_view.dart';
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
    super.initState();
    getValidationData().whenComplete(
      () => Timer(
        const Duration(seconds: 2),
        () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => final_username == null
                ? const LoginPage()
                : ShopRegisterView(
                    id: 1,
                  ),
          ),
        ),
      ),
    );
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedUsername = sharedPreferences.getString('username');
    setState(() {
      final_username = obtainedUsername;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              child: Icon(Icons.local_dining),
            )
          ],
        ),
      ),
    );
  }
}
