import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:HostelApp/main.dart';
import 'package:HostelApp/screens/admin.dart';
import 'package:HostelApp/screens/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageStd extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageStd> {
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isloading = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
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
                    "Enter your mobile and Student ID:",
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
                      controller: _studentIdController,
                      onChanged: (value) {
                        setState(() {
                          _isButtonEnabled = value.length >= 4;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Student ID",
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
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Password",
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
                              String Id = _studentIdController.text.trim();
                              String pass = _passwordController.text.trim();
                              _handleLogin(Id, pass);
                            }
                          : null, // Disable onTap if button is disabled
                      child: !_isloading
                          ? Container(
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
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                              color: Color(0xFF8E94FF),
                            ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleLogin(String studentId, String pass) async {
    setState(() {
      _isloading = true;
    });
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('student')
          .doc(studentId)
          .get();

      if (snapshot['studentId'] == studentId && snapshot['password'] == pass) {
        // Login successful, navigate to the appropriate screen based on the user role
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("ID", studentId);

        // Login successful, navigate to the next screen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        prefs.setString("ust", 'student');
      } else {
        // Show error message as a Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Invalid student ID or mobile number"),
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
    } finally {
      setState(() {
        _isloading = false;
      });
    }
  }
}
