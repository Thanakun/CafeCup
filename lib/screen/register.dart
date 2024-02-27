import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:coffee_application/model/customer.dart';
import 'package:coffee_application/provider/customer-provider.dart';
import 'package:coffee_application/provider/shop_provider.dart';
import 'package:coffee_application/screen/customer_register_view.dart';
import 'package:coffee_application/viewmodel/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/background_logo.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/shop_register/shop_register_first_view.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'dart:async';

import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterVM registerVM;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController(); //here select male and female
  final List<String> usersType = ["Shop", "Customer"];
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    registerVM = RegisterVM(
        customerProvider: context.read<CustomerProvider>(),
        shopProvider: context.read<ShopProvider>());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: backGroundApplication,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundRegisterPath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LogoApplication(),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.0242, vertical: height * 0.0218),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: height * 0.0437),
                              child: Text(
                                "REGISTER",
                                style: kfontH0InterBlackColor(),
                              ),
                            ),
                            toggleUserType(height: height, width: width),
                            SizedBox(height: height * 0.0218),
                            SizedBox(height: height * 0.0174),
                            usernameTextForm(),
                            SizedBox(height: height * 0.0174),
                            passwordTextForm(),
                            SizedBox(height: height * 0.0174),
                            confirmPasswordTextForm(),
                            SizedBox(height: height * 0.0437),
                            SizedBox(
                              width: width,
                              height: height / 12,
                              child: ChangeNotifierProvider(
                                create: (context) => CustomerProvider(),
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll(sup3V4)),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (registerVM.userType == "Customer") {
                                        registerVM.signUpFirstPage(
                                            username: _usernameController.text,
                                            password: _passwordController.text);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const CustomerRegister(),
                                          ),
                                        );
                                      } else if (registerVM.userType ==
                                          "Shop") {
                                        registerVM.signUpFirstPage(
                                            username: _usernameController.text,
                                            password: _passwordController.text);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ShopRegisterView(),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Register',
                                    style: kfontH1InterWhiteColor(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget toggleUserType({required height, required width}) {
    return AnimatedToggleSwitch.size(
      current: registerVM.userType,
      values: usersType,
      iconOpacity: 1,
      height: height * 0.08196,
      indicatorSize: Size.fromWidth(width * 0.2427),
      iconAnimationType: AnimationType.onHover,
      styleAnimationType: AnimationType.onHover,
      iconBuilder: (value) => Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: value == usersType[0]
                ? [
                    WidgetSpan(
                      child: Icon(
                        Icons.local_cafe_outlined,
                        color: registerVM.userType == usersType[0]
                            ? Colors.white
                            : Colors.black,
                        shadows: const [
                          Shadow(
                            blurRadius: 0.5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ]
                : [
                    WidgetSpan(
                      child: Icon(
                        Icons.supervised_user_circle,
                        // color: Colors.white,
                        color: registerVM.userType == usersType[1]
                            ? Colors.white
                            : Colors.black,
                        shadows: const [
                          Shadow(
                            blurRadius: 0.5,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ],
          ),
        ),
      ),
      style: const ToggleStyle(
        borderColor: Colors.transparent,
      ),
      borderWidth: 5.0,
      styleBuilder: (i) {
        final color = colorBuilder(i);
        return ToggleStyle(
          backgroundColor: color.withOpacity(0.3),
          indicatorColor: color,
        );
      },
      onChanged: (i) {
        setState(() => registerVM.userType = i);
      },
    );
  }

  Color colorBuilder(String value) {
    switch (value) {
      case "Customer":
        return backgroundActiveButton;
      // break;
      case "Shop":
        return fontMenuNameColor;
      // break;
      default:
        return Colors.red;
    }
  }

  TextFormField usernameTextForm() {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kYellowSelectedButton, width: 2.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: 'Username',
        labelStyle: kfontH2InterNormalBlackColorHalfOpacity(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
      controller: _usernameController,
    );
  }

  TextFormField confirmPasswordTextForm() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kYellowSelectedButton, width: 2.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: 'Confirm Password',
        labelStyle: kfontH2InterNormalBlackColorHalfOpacity(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please confirm your password';
        } else if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  TextFormField passwordTextForm() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kYellowSelectedButton, width: 2.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: 'Password',
        labelStyle: kfontH2InterNormalBlackColorHalfOpacity(),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    );
  }
}
