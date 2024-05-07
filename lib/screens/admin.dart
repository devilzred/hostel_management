import 'package:HostelApp/screens/admin/Leavcheck.dart';
import 'package:HostelApp/screens/admin/isuuereport.dart';
import 'package:HostelApp/screens/admin/sendNotification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:HostelApp/screens/AuthGate.dart';
import 'package:HostelApp/screens/admin/attendace.dart';
import 'package:HostelApp/screens/admin/attendance_log.dart';
import 'package:HostelApp/screens/admin/feereport.dart';
import 'package:HostelApp/screens/admin/livelog.dart';
import 'package:HostelApp/screens/admin/addstd.dart';
import 'package:HostelApp/screens/admin/model/detailsclass.dart';
import 'package:HostelApp/screens/admin/upldphoto.dart';
import 'package:HostelApp/screens/admin/viewstd.dart';
import 'package:HostelApp/screens/admin/foodmenuadm.dart';
import 'package:HostelApp/screens/customcontainer.dart';
import 'package:HostelApp/screens/student/activityrep.dart';
import 'package:HostelApp/screens/student/contacts.dart';
import 'package:HostelApp/screens/student/food.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color(0xFFF0F0F0),
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.exit_to_app_rounded,
                    color: Color(0xff7364e3), size: 40),
                onPressed: () async {
                  signOut(context);
                },
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: ElevatedButton(
              onPressed: () {
                // Replace with your admin login functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                'Admin',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7364e3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/art.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF0F0F0), Color(0xFFFAFAFA)],
                  stops: [0.25, 0.9],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: CustomPaint(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 130, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.2), // Set shadow color
                                  spreadRadius: 3, // Set spread radius
                                  blurRadius: 10, // Set blur radius
                                  offset: Offset(0, 3), // Set offset
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search anything here',
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 16), // Hint text style
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.fromLTRB(
                                    20, 20, 20, 25), // Padding on all sides
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Quick Links',
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7364e3),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Attendance()));
                                  },
                                  icon: Icon(Icons.library_add_check))
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomContainer(
                                icon: Icons.group_add_rounded,
                                text: 'Register Student',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPage()),
                                  );
                                },
                              ),
                              CustomContainer(
                                icon: Icons.remove_red_eye_rounded,
                                text: 'View Student',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewStudentPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomContainer(
                                icon: Icons.screenshot_monitor,
                                text: 'Live Log',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LiveLog()),
                                  );
                                },
                              ),
                              CustomContainer(
                                icon: Icons.pending_actions_rounded,
                                text: 'Attendence log',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttendenceLog()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AttendenceLog()),
                                  );
                                },
                                child: CustomContainer(
                                  icon: Icons.access_time_outlined,
                                  text: 'Add Attendence',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Attendance()),
                                    );
                                  },
                                ),
                              ),
                              CustomContainer(
                                icon: Icons.nordic_walking_outlined,
                                text: 'Leave Req',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LeaveNotify()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DailyActivityReport()),
                                  );
                                },
                                child: CustomContainer(
                                  icon: Icons.sync_problem,
                                  text: 'Issues Received',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IssueRecieved()),
                                    );
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImportantContactsScreen()),
                                  );
                                },
                                child: CustomContainer(
                                  icon: Icons.notifications_active_sharp,
                                  text: 'Send Notification',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SendNotification()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodMenuUpload()),
                                  );
                                },
                                child: CustomContainer(
                                  icon: Icons.fastfood_rounded,
                                  text: 'Food Menu',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FoodMenuUpload()),
                                    );
                                  },
                                ),
                              ),
                              CustomContainer(
                                icon: Icons.photo_camera_rounded,
                                text: 'Upload Profile',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UploadPhotoPage()),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodMenuUpload()),
                                  );
                                },
                                child: CustomContainer(
                                  icon: Icons.receipt_long_sharp,
                                  text: 'Total Report',
                                  onTap: () {
                                    _openGoogleSheetsLink();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to the login screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthGate(),
      ),
    );
  }

  void _openGoogleSheetsLink() async {
    Uri url = Uri.parse(
        'https://docs.google.com/spreadsheets/d/1N3_EZP4vEatbpnEqhrefUTIwmOt1mWPVl5vXmMfspr0/edit?usp=sharing');
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
