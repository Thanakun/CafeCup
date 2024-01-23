import 'dart:async';
import 'package:flutter/material.dart';
import 'package:coffee_application/screen/home.dart';
// import 'package:get/get.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/screen/shop_register/shop_register_first_view.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          MaterialPageRoute(builder: (context) => const LoginPage()),
        ),
      ),
    );
  }

  Future getValidationData() async {
    Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/landing_page.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
