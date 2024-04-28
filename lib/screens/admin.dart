import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/screens/admin/attendace.dart';
import 'package:hostel_app/screens/login.dart';
import 'package:hostel_app/screens/admin/addstd.dart';
import 'package:hostel_app/screens/admin/viewstd.dart';
import 'package:hostel_app/screens/admin/upldphoto.dart';
import 'package:hostel_app/screens/admin/foodmenuadm.dart';
import 'package:hostel_app/screens/admin/roomsadm.dart';
import 'package:hostel_app/screens/student/issue.dart';
import 'package:hostel_app/screens/student/activityrep.dart';
import 'package:hostel_app/screens/student/contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                icon: Icon(Icons.exit_to_app_rounded, color: Color(0xff7364e3), size: 40),
                onPressed: () async{
                    // Navigate to another page (here a simple message is shown)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                     SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                },
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
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
            padding: const EdgeInsets.only(right: 30.0),
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
      body:  SingleChildScrollView(
        child: Stack(
        children: [
          // Background image
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
          // Main content
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Container(
                    padding: EdgeInsets.fromLTRB(30, 130, 30, 30),
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
          color: Colors.grey.withOpacity(0.2), // Set shadow color
          spreadRadius: 3, // Set spread radius
          blurRadius: 10, // Set blur radius
          offset: Offset(0, 3), // Set offset
        ),
      ],
    ),
  child: TextField(
    decoration: InputDecoration(
      hintText: 'Search anything here',
      hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 16), // Hint text style
      border: InputBorder.none,
      prefixIcon: Icon(Icons.search),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 25), // Padding on all sides
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
                                  onPressed: (){Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Attendance()));},
                                  icon: Icon(Icons.library_add_check))
                            ],
                          ),
SizedBox(height: 30),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPage()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.group_add_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Register Student',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 20),
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewStudentPage()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_red_eye_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'View Student',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Second row of containers
    GestureDetector(
      onTap: () {
       
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Notifications',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 20),
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ManageRoomsPage()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.hotel_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Manage Rooms',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Third row of containers
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DailyActivityReport()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Total Report',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 20),
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImportantContactsScreen()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_money_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Fee Report',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
  ],
),
SizedBox(height: 20),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Second row of containers
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodMenuUpload()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fastfood_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Food Menu',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
      ),
    ),
    SizedBox(width: 20),
    GestureDetector(
      onTap: () {
       Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UploadPhotoPage()),
            );
      },
      child: Container(
        width: 210,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_camera_rounded,
              size: 80,
              color: Color(0xff7364e3),
            ),
            SizedBox(height: 10),
            Text(
              'Upload Profile',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff7364e3),
              ),
            ),
          ],
        ),
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
}
