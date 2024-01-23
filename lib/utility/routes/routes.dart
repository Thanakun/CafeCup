import 'package:flutter/material.dart';
import 'package:coffee_application/screen/Splashscreen.dart';
import 'package:coffee_application/screen/home.dart';
import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/utility/routes/routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguement = settings.arguments;
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: ((context) => HomeScreen()));
      case RoutesName.login:
        return MaterialPageRoute(builder: ((context) => const LoginPage()));
      case RoutesName.splash:
        return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
