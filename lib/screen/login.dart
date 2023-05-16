import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/model/users.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

bool isPasswordVisible = false;

class _loginState extends State<login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  final formKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  static const ROOT_Login =
      'http://192.168.1.103/flutter_application_1/lib/xamppfiles/Login.php';

  Future sign_in() async {
    final response = await http.post(Uri.parse(ROOT_Login), body: {
      'username': _usernameController.text,
      'password': _passwordController.text,
    });
    print("here is a data ${response.body}");
    var data = await json.decode(response.body);
    // print(response.body);
    if (data.toString() == "Success") {
      // print("kuy");
      Fluttertoast.showToast(
          msg: 'Login Successful',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Fluttertoast.showToast(
          msg: 'Username and password invalid',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      Image(
                        image: const AssetImage('assets/images/table_icon.png'),
                        color: Colors.black.withOpacity(0.5),
                        width: 200,
                        height: 200,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Center(
                  child: Text(
                    "Wong Nok",
                    style: TextStyle(
                        fontFamily: "THSarabun",
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "เพราะเรื่องกินเป็นเรื่องใหญ่",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "THSarabun",
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100)),
                                // borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email or username",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                                controller: _usernameController,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100)),
                                // borderRadius: BorderRadius.circular(10)
                              ),
                              child: TextFormField(
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
                                    hintText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400)),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                                controller: _passwordController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(colors: [
                                Color.fromRGBO(234, 191, 128, 1),
                                Color.fromRGBO(234, 191, 128, 0.6)
                              ])),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontFamily: "THSarabun",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'username', _usernameController.text);
                          sign_in();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          "Didn't have Account? Sign up now",
                          style:
                              TextStyle(color: Color.fromRGBO(250, 152, 4, 1)),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
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
}
