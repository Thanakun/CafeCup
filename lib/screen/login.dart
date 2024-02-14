import 'package:coffee_application/screen/customer_shop_view.dart';
import 'package:coffee_application/service/auth-service/auth-service.dart';
import 'package:coffee_application/utility/helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/screen/register.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

bool isPasswordVisible = false;

class LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _username = '', _passowrd = '';

  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Stack(
          children: <Widget>[
            // Image(image: AssetImage('assets/images/table_icon.png')),
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background_crop.jpg"),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height,
                    // padding: const EdgeInsets.only(right: 14, bottom: 568),
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Color(0xFFFFF5E9)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logoApplication(),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 10),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.0364, vertical: 0.01639),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(234, 191, 128, 0.3),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.0437,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100)),
                                // borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "LOGIN.USERNAME".tr(),
                                    hintStyle: GoogleFonts.openSans(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w600)),
                                validator: Helper.validateUsername,
                                controller: _usernameController,
                              ),
                            ),
                            sectionBufferHeight(bufferSection: height * 0.0219),
                            Container(
                              height: height * 0.0437,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100)),
                                // borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                textAlign: TextAlign.start,
                                obscureText: isPasswordVisible ? false : true,
                                decoration: InputDecoration(
                                    suffixIconConstraints: const BoxConstraints(
                                        minWidth: 45, maxWidth: 46),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isPasswordVisible =
                                              !isPasswordVisible;
                                        });
                                      },
                                      child: Icon(
                                        isPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.shade500,
                                        size: 22,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintText: "LOGIN.PASSWORD".tr(),
                                    hintStyle: GoogleFonts.openSans(
                                        color: Colors.grey.shade400,
                                        fontWeight: FontWeight.w600)),
                                validator: Helper.validatePassword,
                                controller: _passwordController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0327,
                      ),
                      TextButton(
                        child: Container(
                          height: height * 0.055,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(234, 191, 128, 1),
                                Color.fromRGBO(234, 191, 128, 0.6)
                              ])),
                          child: Center(
                            child: Text(
                              "BUTTON.LOGIN".tr(),
                              style: const TextStyle(
                                  fontFamily: "THSarabun",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_usernameController.text.isEmpty &&
                              _passwordController.text.isEmpty) {
                            Utility.flushBarErrorMessage(
                              message:
                                  "LOGIN.PLEASE_ASSIGN_USERNAME_PASSWORD".tr(),
                              context: context,
                            );
                          }

                          if (_usernameController.text.isEmpty) {
                            Utility.flushBarErrorMessage(
                                message: "LOGIN.PLEASE_ENTER_USERNAME".tr(),
                                context: context);
                          }

                          if (_passwordController.text.isEmpty) {
                            Utility.flushBarErrorMessage(
                                message: "LOGIN.PLEASE_ENTER_PASSWORD".tr(),
                                context: context);
                          }
                          _username = _usernameController.text;
                          _passowrd = _passwordController.text;
                          bool isLoginSuccess =
                              await authService.login(_username, _passowrd);

                          if (isLoginSuccess) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CustomerHomePageView(),
                              ),
                            );
                          } else {
                            print(isLoginSuccess);
                            Utility.flushBarErrorMessage(
                                message: "ERROR_MESSAGE.LOGIN_FAILED".tr(),
                                context: context);
                          }
                        },
                      ),
                      sectionBufferHeight(bufferSection: 10),
                      TextButton(
                        child: Text(
                          "LOGIN.SIGN_UP_CREATE_ACCOUNT".tr(),
                          style: GoogleFonts.openSans(
                              color: const Color(0xFFC08261),
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SizedBox logoApplication() {
    return SizedBox(
      width: 524,
      height: 360,
      child: Stack(
        children: [
          Positioned(
            left: -150,
            top: -150,
            child: backGroundBrownBall(),
          ),
          Positioned(
            left: 100,
            top: 50,
            child: Opacity(
              opacity: 0.20,
              child: backGroundLowOpacityBall(),
            ),
          ),
          Positioned(
            left: 130,
            top: 130,
            child: titleTextOfApplication(),
          ),
        ],
      ),
    );
  }

  Text titleTextOfApplication() {
    return Text('APP_TITLE'.tr(),
        textAlign: TextAlign.center,
        style: GoogleFonts.pacifico(
          color: const Color(0xFF352B19),
          fontSize: 60,
          fontWeight: FontWeight.w400,
          height: 0,
        )
        // TextStyle(
        //   color: Color(0xFF352B19),
        //   fontSize: 40,
        //   fontFamily: GoogleFonts(),
        //   fontWeight: FontWeight.w400,
        //   height: 0,
        // ),
        );
  }

  Container backGroundLowOpacityBall() {
    return Container(
      width: 200,
      height: 200,
      decoration: const ShapeDecoration(
        color: Color(0xFFB99470),
        shape: OvalBorder(),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }

  Container backGroundBrownBall() {
    return Container(
      width: 360,
      height: 360,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF643303), Color(0xFFAF5523)],
        ),
        shape: OvalBorder(),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
    );
  }
}
