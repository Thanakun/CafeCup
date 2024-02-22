import 'package:coffee_application/screen/login.dart';
import 'package:coffee_application/screen/my_component/bottom_navigationbar_customer.dart';
import 'package:coffee_application/utility/decoration.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/viewmodel/logout_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({super.key});

  @override
  State<LogOutPage> createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  LogoutVM logoutVM = LogoutVM();

  @override
  void initState() {
    super.initState();
    logoutVM = LogoutVM();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomerNavigationBar(
          pageName: "LOGOUT",
        ),
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundCustomerHomeImagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  logoutVM.logout();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: kdecorationForContainerButton,
                  padding: EdgeInsets.all(width * 0.05),
                  child: Text(
                    "LOGOUT",
                    style: kfont32_400(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
