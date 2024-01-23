import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:coffee_application/data/widget/background_logo.dart';
import 'package:coffee_application/model/shop.dart';
import 'package:coffee_application/screen/shop_register/shop_register_first_view.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'dart:async';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final List<String> genderOption = [
    'Any',
    'Male',
    'Female'
  ]; //here select male and female
  final List<String> ageOption = ['3-6', '>19', '>35+'];
  static const rootRegister =
      'http://10.126.160.76/coffee_application/lib/xamppfiles/Register.php'; // IP Change to your Computer
  final List<String> usersType = ["Shop", "Customer"];
  List<bool> isSelected = [true, false];
  late String selectedAge = ageOption.elementAt(1);
  late String selectedGender = genderOption.first;
  String selectedType = "Customer";
  bool isPasswordVisible = false;

  Future _signUp() async {
    if (usersType.first == "Shop") {
      // Create a ShopModel instance
      ShopModel shopModel = ShopModel(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      // print(response.body);
      // } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ShopRegisterView(id: 1)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String selectedGender = genderOption.first;
    String selectedAge = ageOption.elementAt(1);
    selectedType = "Customer";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(255, 245, 233, 1),
      body: Column(
        children: [
          LogoApplication(),
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
                        toggleUserType(height: height,width: width),
                        SizedBox(height: height * 0.0218),
                        SizedBox(height: height * 0.0174),
                        usernameTextForm(),
                        SizedBox(height: height * 0.0174),
                        passwordTextForm(),
                        SizedBox(height: height * 0.0174),
                        confirmPasswordTextForm(),
                         SizedBox(height:height*0.0437),
                        SizedBox(
                          width: width,
                          height: height / 12,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(sup3V4)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Validation passed, register user
                                _signUp();
                              }
                            },
                            child: Text(
                              'Register',
                              style: kfontH1InterWhiteColor(),
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
    );
  }

  Widget toggleUserType({required height,required width}) {
    return AnimatedToggleSwitch.size(
      current: selectedType,
      values: usersType,
      iconOpacity: 1,
      height: height * 0.08196,
      indicatorSize: Size.fromWidth( width*0.2427),
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
                        color: selectedType == usersType[0]
                            ? Colors.white
                            : Colors.black,
                        shadows: [
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
                        color: selectedType == usersType[1]
                            ? Colors.white
                            : Colors.black,
                        shadows: [
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
        setState(() => selectedType = i);
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

  TextFormField emailTextForm() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        }
        return null;
      },
    );
  }

  TextFormField usernameTextForm() {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: supV4, width: 2.5),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: supV4, width: 2.5),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: backgroundActiveButton,
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: supV4, width: 2.5),
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

  DropdownButtonFormField<String> ageDropdown() {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Age',
          prefixIcon: Icon(Icons.manage_accounts),
        ),
        value: selectedAge,
        items: ageOption.map((age) {
          return DropdownMenuItem(
              value: age,
              child: Text(
                age,
                style: const TextStyle(
                    fontFamily: "THSarabun",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedAge = value.toString();
          });
        });
  }

  DropdownButtonFormField<String> genderDropdown() {
    return DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'Gender',
          prefixIcon: Icon(Icons.face),
        ),
        value: selectedGender,
        items: genderOption.map((gender) {
          return DropdownMenuItem(
              value: gender,
              child: Text(
                gender,
                style: const TextStyle(
                    fontFamily: "THSarabun",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ));
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGender = value.toString();
          });
        });
  }

  Future _registerUser(String email, String username, String password) async {}
}
