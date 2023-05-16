import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/utility/my_constant.dart';
import 'package:flutter_application_1/screen/home_users.dart';
// import 'package:flutter_application_1/model/check_login.dart';

// Future main() async(){
//   WidgetFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
// }

// class HomeScreen extends StatelessWidget {

//   final formkey = GlobalKey<FormState>();
//   @override
//   Future<void> log_out(BuildContext context) async {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => login()));
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register/Login"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//               gradient: LinearGradient(
//             colors: [Colors.pink.shade200, Colors.purple.shade200],
//           )),
//         ),
//         elevation: 20,
//         titleSpacing: 0,
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//             sharedPreferences.remove('username');
//             await log_out(context); // pass context parameter
//           },
//           child: Text('Logout'),
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  @override
  Future<void> log_out(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => login()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Stack(
        children: <Widget>[
          // Image(image: AssetImage('assets/images/table_icon.png')),
          Container(
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
          Column(children: [
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
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Container(
                            height: 100,
                            width: 250,
                            // color: Colors.red,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kRedButton
                            ),
                            child: Center(
                              child: Text(
                                'Home',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontFamily: "THSarabun",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => home_users()));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            'Check-in',
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                                    fontFamily: "THSarabun",
                                    fontWeight: FontWeight.bold
                            ),
                          )),
                          height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kYellowSelectedButton
                            // borderRadius: BorderRadius.circular(15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.remove('username');
                        await log_out(context); // pass context parameter
                      },
                      child: Text('Logout'),
                    ),
                  )
                ],
              ),
            ),
          ])
        ],
      )),
    );
  }
}
