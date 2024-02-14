import 'dart:io';

import 'package:coffee_application/data/network/dio_network_api_service.dart';
import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/viewmodel/splash_screen_view_model.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SplashScreenVM _splashScreenVM;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    _splashScreenVM = SplashScreenVM();

    bool isTokenValid = await _splashScreenVM.validateToken();

    if (isTokenValid) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const CustomerHomePageView(), // Replace with your home page widget
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const LoginPage(), // Replace with your login page widget
        ),
      );
    }
  }

  Future<String> getDocPath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
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
