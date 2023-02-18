import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart'; 
import 'screen/home.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var app = new MyApp();

  runApp(app);
}




//สร้าง widget
class MyApp extends StatelessWidget{
  const MyApp({Key ? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',theme: ThemeData(
        primarySwatch: Colors.purple
      ),
      home:HomeScreen()
    );

  }
}