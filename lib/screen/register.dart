import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:uri/uri.dart';
import 'package:flutter_application_1/model/users.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
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
  static const ROOT_Register =
      'http://192.168.1.103/flutter_application_1/lib/xamppfiles/Register.php'; // IP Change to your Computer
  List<bool> isSelected = [true, false];
  late String selectedAge = ageOption.elementAt(1);
  late String selectedGender = genderOption.first;
  late String Selected_type = "Customer";
  bool isPasswordVisible = false;

  Future sign_up() async {
    final response = await http.post(Uri.parse(ROOT_Register), body: {
      'username': _usernameController.text,
      'password': _passwordController.text,
      'email': _emailController.text,
      'gender': selectedGender.toString(),
      'age': selectedAge,
      'user_point': "0",
      'user_role': Selected_type.toString()
    });
    print(response.body);
    var data = await json.decode(json.encode(response.body));
    print(data);
    if (data == "Error") {
       Fluttertoast.showToast(
          msg: 'Error',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String selectedGender = genderOption.first;
    String selectedAge = ageOption.elementAt(1);
    Selected_type = "Customer";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                    const Text("for the shop and customer",
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: "THSarabun",
                            fontWeight: FontWeight.normal)),
                    SizedBox(height: 20),
                    Container(
                      child: ToggleButtons(
                        borderRadius: BorderRadius.circular(15),
                        selectedColor: Colors.white,
                        color: Colors.black,
                        renderBorder: true,
                        fillColor: Colors.pink.shade300,
                        splashColor: Colors.pink.shade400,
                        highlightColor: Colors.red,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Customer',
                                style: TextStyle(
                                    fontSize: 25, fontFamily: "THSarabun")),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text('Shop',
                                style: TextStyle(
                                    fontSize: 25, fontFamily: "THSarabun")),
                          ),
                        ],
                        isSelected: isSelected,
                        onPressed: (int newIndex) {
                          setState(() {
                            // looping through the list of booleans values
                            for (int index = 0;
                                index < isSelected.length;
                                index++) {
                              // checking for the index value
                              if (index == newIndex) {
                                // one button is always set to true
                                isSelected[index] = true;
                                Selected_type =
                                    (isSelected[0]) ? "Customer" : "Shop";
                              } else {
                                // other two will be set to false and not selected
                                isSelected[index] = false;
                                Selected_type =
                                    (isSelected[1]) ? "Shop" : "Customer";
                              }
                            }
                          });
                        },
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      controller: _usernameController,
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          prefixIcon: Icon(Icons.face),
                        ),
                        value: selectedGender,
                        items: genderOption.map((gender) {
                          return DropdownMenuItem(
                              value: gender,
                              child: Text(
                                gender,
                                style: TextStyle(
                                    fontFamily: "THSarabun",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value.toString();
                          });
                        }),
                    SizedBox(height: 16),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Age',
                          prefixIcon: Icon(Icons.manage_accounts),
                        ),
                        value: selectedAge,
                        items: ageOption.map((age) {
                          return DropdownMenuItem(
                              value: age,
                              child: Text(
                                age,
                                style: TextStyle(
                                    fontFamily: "THSarabun",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAge = value.toString();
                          });
                        }),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Validation passed, register user
                          sign_up();
                        }
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _registerUser(String email, String username, String password) async {}
}
