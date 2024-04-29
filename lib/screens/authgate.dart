import 'package:flutter/material.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:hostel_app/screens/loginmain.dart';
import 'package:hostel_app/screens/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool login = false;
  bool admin = false;
  Widget? _defaultHome;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("ust");
    if (username != null) {
      login = true;
      admin = username == 'admin';
      _defaultHome = admin ? AdminHomeScreen() : HomeScreen();
    } else {
      login = false;
      _defaultHome = LoginPage();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _defaultHome ?? CircularProgressIndicator();
  }
}
