import 'dart:ffi';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/model/users.dart';
import 'package:path/path.dart' as Path;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_application_1/model/check_login.dart';

// Future main() async(){
//   WidgetFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
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
      appBar: AppBar(
        title: Text("Register/Login"),
        centerTitle: true,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.pink.shade200, Colors.purple.shade200],
          )),
        ),
        elevation: 20,
        titleSpacing: 0,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.remove('username');
            await log_out(context); // pass context parameter
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}

class Home_Text extends StatelessWidget {
  const Home_Text({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 60, 20),
        child: Text('Welcome to Finding Your Favorites Restaurant'),
      ),
    );
  }
}

class input_password extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  const input_password({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<input_password> createState() => _input_passwordState();
}

class _input_passwordState extends State<input_password> {
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        controller: passwordController,
        obscureText: true,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Password',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}

class Input_username extends StatefulWidget {
  final ValueChanged<String> onSubmitted;
  const Input_username({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  State<Input_username> createState() => _Input_usernameState();
}

class _Input_usernameState extends State<Input_username> {
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        controller: usernameController,
        // obscureText: true,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}

class SubmitLogin extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitLogin({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: onPressed,
      ),
    );
  }
}

class ToRegister extends StatelessWidget {
  const ToRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Register'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return RegisterPage();
          }));
        },
      ),
    );
  }
}

class ToLogin extends StatelessWidget {
  const ToLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return login();
          }));
        },
      ),
    );
  }
}
