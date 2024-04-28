import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_fonts/google_fonts.dart';

class ViewStudentPage extends StatefulWidget {
  @override
  _ViewStudentPageState createState() => _ViewStudentPageState();
}

class _ViewStudentPageState extends State<ViewStudentPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchId = '  ';
  bool _searching = false;

  Future<DocumentSnapshot?> _getStudentDetails(String id) async {
    DocumentSnapshot? snapshot =
        await FirebaseFirestore.instance.collection('student').doc(id).get();
    return snapshot;
  }

  Future<String> _getStudentImageURL(String id) async {
    // Construct the path to the image in Firebase Storage using the student ID
    String imagePath =
        'student_images/$id.jpg'; // Assuming the images are stored with .jpg extension
    // Get the download URL for the image
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(imagePath)
        .getDownloadURL();
    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
        title: Text(
          'View Student Details',
          style: GoogleFonts.poppins(
            fontSize: 22, // Adjust the font size
            fontWeight: FontWeight.bold, // Adjust the font weight
            color: Color(0xff7364e3), // Adjust the text color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
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
                controller: _searchController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  hintText: 'Search by Student ID',
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.grey, fontSize: 16), // Hint text style
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
                        _searching = true;
                        _searchId = _searchController.text;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            _searching
                ? FutureBuilder<DocumentSnapshot?>(
                    future: _getStudentDetails(_searchId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          if (snapshot.data == null || !snapshot.data!.exists) {
                            return Center(child: Text('Student not found'));
                          } else {
                            var studentData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return FutureBuilder<String>(
                              future: _getStudentImageURL(_searchId),
                              builder: (context, imageSnapshot) {
                                if (imageSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  if (imageSnapshot.hasError) {
                                    return Container();
                                  } else {
                                    String imageUrl = imageSnapshot.data!;
                                    return GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              child: Container(
                                                width: 500,
                                                height: 500,
                                                child: Image.network(
                                                  imageUrl,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Center(
                                        // Wrapping with Center widget to center the container
                                        child: Container(
                                          width: 250,
                                          height:
                                              250, // Adjust the height as needed
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .white, // Set background color to white
                                            borderRadius: BorderRadius.circular(
                                                10), // Apply border radius
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.scaleDown,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          }
                        }
                      }
                    },
                  )
                : Container(),
            SizedBox(height: 20.0),
            _searching
                ? FutureBuilder<DocumentSnapshot?>(
                    future: _getStudentDetails(_searchId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          if (snapshot.data == null || !snapshot.data!.exists) {
                            return Text('Student not found');
                          } else {
                            var studentData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${studentData['name']}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Color(0xFF7364E3),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.offline_pin_rounded,
                                        color: Color(0xFF7364E3),
                                        size: 20.0,
                                      ),
                                      onPressed: () {
                                        // Implement functionality for editing student's name
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(
                                  width: double.infinity,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DOB: ${studentData['dob']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Color(0xFF7364E3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'College: ${studentData['college']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Color(0xFF7364E3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Course: ${studentData['course']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Color(0xFF7364E3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Parent Name: ${studentData['parentName']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Color(0xFF7364E3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Parent Mobile: ${studentData['parentMobile']}',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF7364E3),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Address: ${studentData['address']}',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF7364E3),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Room Number: ${studentData['roomNumber']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Color(0xFF7364E3),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Text(
                                          'Mobile: ${studentData['mobile']}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF7364E3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      }
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ViewStudentPage(),
  ));
}
