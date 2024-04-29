import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_app/screens/AuthGate.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:hostel_app/screens/loginstudent.dart';
import 'package:hostel_app/screens/loginmain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'package:hostel_app/screens/student.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}
  // bool login=false;
  // bool admin=false;


class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
      // Define the home property based on login status
      home: const AuthGate(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
// void _navigateToNextScreen() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? username=prefs.getString("ust");
//     if(username!=Null) {
      
//       login=true;
//       if (username=='admin') {
//         admin=true;
//       } 
//     }else{
//      login=false;
//     }
//     }