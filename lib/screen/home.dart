import 'package:coffee_application/screen/login.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coffee_application/utility/my_constant.dart';
import 'package:coffee_application/screen/home_users.dart';

class HomeScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  HomeScreen({super.key});

  Future<void> _logOut(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Stack(
        children: <Widget>[
          // Image(image: AssetImage('assets/images/table_icon.png')),
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
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
                                color: kRedButton),
                            child: const Center(
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
                                    builder: (context) => const HomeUsers()));
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
                          height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: kYellowSelectedButton
                              // borderRadius: BorderRadius.circular(15),
                              ),
                          child: const Center(
                              child: Text(
                            'Check-in',
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontFamily: "THSarabun",
                                fontWeight: FontWeight.bold),
                          )),
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
                        await _logOut(context);
                        //https://stackoverflow.com/questions/68871880/do-not-use-buildcontexts-across-async-gaps // pass context parameter
                      },
                      child: const Text('Logout'),
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
