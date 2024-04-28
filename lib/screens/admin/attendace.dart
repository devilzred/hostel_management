import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final TextEditingController _searchController = TextEditingController();
  String _searchId = '';

  // This method is not needed for the simplified functionality
  // Future<DocumentSnapshot?> _getStudentDetails(String id) async { ... }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            SizedBox(height: 20.0),
            _searchId.isNotEmpty
                ? _buildStudentInfo(_searchId)
                : Container(), // Show student info only when searching
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
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
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          color: Color(0xFF7364E3),
        ),
        decoration: InputDecoration(
          hintText: 'Search by Student ID',
          hintStyle:
              GoogleFonts.poppins(color: Colors.grey, fontSize: 16), // Hint text style
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.person_search_rounded,
            color: Color(0xff7364e3),
          ),
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 25),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.send_rounded,
              color: Color(0xff7364e3),
            ),
            onPressed: () {
              setState(() {
                _searchId = _searchController.text;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStudentInfo(String studentId) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('student').doc(studentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('Student not found'));
            } else {
              var studentData = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${studentData['name']}',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Color(0xFF7364E3),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                
                          ElevatedButton(
                            onPressed: () {
                              _markAttendance(studentId, true);
                            },
                            child: Text("Mark In"),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () {
                              _markAttendance(studentId, false);
                            },
                            child: Text("Mark Out"),
                          ),
                    ],
                  ),
                ],
              );
            }
          }
        }
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF0F0F0),
      toolbarHeight: 80,
      leading: IconButton(
        padding: const EdgeInsets.all(20),
        icon: const Icon(
          Icons.navigate_before_rounded,
          size: 35,
          color: Color(0xff7364e3),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Students Attendance',
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xff7364e3),
        ),
      ),
    );
  }

  Future<void> _markAttendance(String studentId, bool isIn) async {
    try {
      await FirebaseFirestore.instance.collection('attendance').doc(studentId).set({
        'isIN': isIn,
        'timestamp': DateTime.now(),
      }, SetOptions(merge: true));
      // Success message or any additional handling
    } catch (error) {
      print('Error marking attendance: $error');
      // Handle error
    }
  }
}