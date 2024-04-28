import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/screens/AuthGate.dart';
import 'package:hostel_app/screens/loginmain.dart';
import 'package:hostel_app/screens/student/food.dart';
import 'package:hostel_app/screens/student/leave.dart';
import 'package:hostel_app/screens/student/notification.dart';
import 'package:hostel_app/screens/student/issue.dart';
import 'package:hostel_app/screens/student/activityrep.dart';
import 'package:hostel_app/screens/student/contacts.dart';
import 'package:hostel_app/screens/student/payment.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:hostel_app/screens/loginstudent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "Hadil";
  String profilePhotoUrl = "assets/images/profile_photo.jpg";

  TextEditingController adminPasswordController = TextEditingController();
  String adminPassword = "admin123"; // Replace with your actual admin password

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdminLogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Admin Login"),
          content: Column(
            children: [
              TextField(
                controller: adminPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Enter Admin Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (adminPasswordController.text == adminPassword) {
                  Navigator.pop(context); // Close the dialog
                  _navigateToAdminScreen();
                } else {
                  // Show error message or handle incorrect password
                }
              },
              child: Text("Login"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAdminScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminHomeScreen(),
      ),
    );
  }

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
          padding: const EdgeInsets.only(
            left: 18.0,
          ),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.sort, color: Color(0xff7364e3), size: 40),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
            ),
            child: ElevatedButton(
              onPressed: _onAdminLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                'Hy Hadil :)',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7364e3),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 30.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff7364e3), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage(profilePhotoUrl),
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
                          Text(
                            'Your Payments',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: 600, // Set your desired width
                            padding: EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
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
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(
                                          0xff7364e3), // Set your desired background color
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentScreen()),
                                        );
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Color(
                                            0xFFFFFFFF), // Set your desired arrow color
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Total estimated bill',
                                          style: GoogleFonts.poppins(
                                            fontSize: 22,
                                            color: Color(0xff7364e3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Add some space between the two texts
                                        Text(
                                          'Your total bill of November month:',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF9B9B9B),
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                10), // Add some space between the two texts
                                        Row(
                                          children: [
                                            Text(
                                              '₹',
                                              style: TextStyle(
                                                fontSize: 48,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff7364e3),
                                              ),
                                            ),
                                            Text(
                                              '5100',
                                              style: GoogleFonts.ultra(
                                                fontSize: 48,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff7364e3),
                                              ),
                                            ),
                                            Text(
                                              '/-',
                                              style: GoogleFonts.ultra(
                                                fontSize: 48,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xff7364e3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ), // Add space between texts and button
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        // Add your onTap functionality here
                                      },
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentScreen()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(
                                              0xff7364e3), // Set your desired button color
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          minimumSize: Size(double.infinity,
                                              50), // Set button width to full
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            'Pay Now',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Quick Links',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // First row of containers
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodMenu()),
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LeaveRequestScreen()),
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
                                        Icons.announcement_rounded,
                                        size: 80,
                                        color: Color(0xff7364e3),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Leave Request',
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen()),
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReportIssueScreen()),
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
                                        Icons.report_problem_rounded,
                                        size: 80,
                                        color: Color(0xff7364e3),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Report an issue',
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DailyActivityReport()),
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
                                        Icons.content_paste_rounded,
                                        size: 80,
                                        color: Color(0xff7364e3),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Activity Report',
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
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImportantContactsScreen()),
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
                                        Icons.person_pin_rounded,
                                        size: 80,
                                        color: Color(0xff7364e3),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Imp. Contacts',
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
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ), // Specify border radius here
                  ),
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 20), // Add bottom padding here
                    child: Image.asset(
                      'assets/images/mainlogo.png',
                      height: 40,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color(
                        0xff7364e3), // Specify your desired background color here
                    borderRadius: BorderRadius.circular(
                        10), // Specify the border radius here
                  ),
                  child: ListTile(
                    title: Text(
                      'Home',
                      style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    onTap: () {
                      // Add functionality for menu item 1
                    },
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Payments',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.attach_money_rounded,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Resident',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.hotel,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false);
                  },
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 40),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(
                        color: Color(0xff7364e3),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () async {
                    // Navigate to another page (here a simple message is shown)
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
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
}
