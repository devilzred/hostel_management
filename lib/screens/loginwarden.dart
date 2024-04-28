import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/main.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:hostel_app/screens/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageWadern extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWadern> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Image.asset('assets/images/light-2.png'),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Image.asset('assets/images/clock.png'),
                  ),
                  Positioned(
                    // Center the Text widget
                    left: 0,
                    right: 0,
                    top: 160,
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enter your Username and Admin ID:",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30),
                  // Mobile Number TextField
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _phoneNumberController,
                      
                      onChanged: (value) {
                        setState(() {
                          _isButtonEnabled = value.length == 5;
                        });
                      },
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Username",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Student ID TextField
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(143, 148, 251, .2),
                          blurRadius: 20.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _studentIdController,
                      keyboardType: TextInputType.number,
                      
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter AdminId",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Submit Button
                  GestureDetector(
                    onTap: _isButtonEnabled
                        ? () {
                            String Phone = _phoneNumberController.text;
                            String Id = _studentIdController.text;
                            _handleLogin(Phone, Id);
                            print(Id);
                            print(Phone);
                          }
                        : null, // Disable onTap if button is disabled
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _isButtonEnabled
                            ? Color(0xFF8E94FF)
                            : Color(0xFF8E94FF).withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          "SUBMIT",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin(String username, String adminId) async {
    try {
      if (username == 'admin' && adminId == '1234') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomeScreen()),
            (route) => false);
        prefs.setString("ust", 'admin');
      } else {
        // Show error message as a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid Admin ID or Username"),
          ),
        );
      }
    } catch (e) {
      // Show error message as a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred during login"),
        ),
      );
    }
  }
}
