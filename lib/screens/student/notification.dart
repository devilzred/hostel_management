// not used but written another file to ascces the notificatiobn

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    String? formattedDateTime;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F0F0),
        toolbarHeight: 80.0,
        leading: IconButton(
          padding: EdgeInsets.all(20.0),
          icon: Icon(
            Icons.navigate_before_rounded,
            size: 35,
            color: Color(0xff7364e3),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: FutureBuilder<String?>(
        future: _getStudentId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final studentId = snapshot.data;
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('attendance')
                  .doc(studentId)
                  .snapshots(),
                  
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!.data();
                if (data == null || data.isEmpty) {
                  Timestamp timestamp = data?['timestamp'];
                  DateTime dateTime = timestamp.toDate();
String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}
// Format the DateTime object as a string
formattedDateTime = '${dateTime.day} ${dateTime.month} ${dateTime.year} at ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

// Helper function to get the month name

                  return Center(
                    child: Text('No notifications.'),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ), // Add space between cards
                        child: ListTile(
                          leading: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff7364e3), // Background color
                                ),
                                padding: EdgeInsets.all(12), // Adjust padding as needed
                                child: Icon(
                                  Icons.notifications,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 25,
                                ),// Notification icon
                              ),
                              // Add your unread notification indicator logic here
                            ],
                          ),
                          title: Text(
                            studentId?? 'Dear student' ,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          subtitle: Text(
                             formattedDateTime ?? 'Now',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          onTap: () {
                            // Handle notification click
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<String?> _getStudentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("ID");
  }
}