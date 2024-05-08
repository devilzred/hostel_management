import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:HostelApp/screens/student.dart';
import 'package:HostelApp/screens/admin.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import Firestore

class SendNotification extends StatelessWidget {
  final TextEditingController mattertitle = TextEditingController();
  final TextEditingController matterdes =
      TextEditingController();
  bool isSubmitted = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Container(
            child: AppBar(
              backgroundColor: Color(0xFFF0F0F0),
              toolbarHeight: 80.0,
              leading: IconButton(
                padding: EdgeInsets.all(20.0),
                icon: Icon(
                  Icons.navigate_before_rounded, // Change to navigate_before
                  size: 35, // Adjust the size of the icon
                  color: Color(0xff7364e3), // Adjust the color of the icon
                ),
                onPressed: () {
                  _onBackPressed(context);
                },
              ),
              title: Text(
                'Notifi Students',
                style: GoogleFonts.poppins(
                  fontSize: 22, // Adjust the font size
                  fontWeight: FontWeight.bold, // Adjust the font weight
                  color: Color(0xff7364e3), // Adjust the text color
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7364e3),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: mattertitle,
                    decoration: InputDecoration(
                      hintText: 'Title of the Matter',
                      contentPadding: EdgeInsets.all(20.0),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xB97364E3),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Details (Optional)',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff7364e3),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: matterdes,
                    decoration: InputDecoration(
                      hintText: 'Describe the Matter',
                      contentPadding: EdgeInsets.all(20.0),
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xB97364E3),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width:
                        double.infinity, // Make button width equal to page width
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submit(context);
                        }
                        
                      },
                      style: ElevatedButton.styleFrom(
                        // primary: Color(0xff7364e3), // Background color
                        // onPrimary: Colors.white, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Border radius
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 16, horizontal: 24), // Button padding
                      ),
                      child: Text(
                        'Send Notification',
                        style: GoogleFonts.poppins(
                            fontSize: 14, // Text size
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you sure?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Do you want to leave without Sending Notification?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
            Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => AdminHomeScreen()),
            (route) => false);
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false; // Return false if result is null
  }

  Future<void> _submit(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id = prefs.getString('ID') ?? '';
      // Access Firestore instance
      final CollectionReference IssueCollection =
          FirebaseFirestore.instance.collection('notifications');

      // Store leave request data
      await IssueCollection.add({
        'admin': id,
        'date': DateTime.now(),
        'title': mattertitle.text.trim(),
        'description': matterdes.text.trim(),
      });

      // Show success alert
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Success',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
            content: Text(
              'Reported successfully.',
              style: GoogleFonts.poppins(),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Clear input fields after success
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Print error message
      print('Error submitting Report: $e');
    }
  }
}
