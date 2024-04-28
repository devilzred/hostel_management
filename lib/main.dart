import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:hostel_app/screens/login.dart';
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
void initState() {
    initState();
    _navigateToNextScreen();
  }
  bool login=false;
  bool admin=false;
  bool user=false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
      // Define the home property based on login status
      home: login ? (admin ? AdminHomeScreen() : HomeScreen()) : LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
void _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username=prefs.getString("ust");
    if(username!=Null) {
      login=true;
      if (username=='admin') {
        admin=true;
      } else if(username=='student') {
        user=true;
      }
    }else{
     login=false;
    }
    }