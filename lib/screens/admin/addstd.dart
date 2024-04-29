import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/screens/admin.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:google_fonts/google_fonts.dart';

class AddPage extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentMobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  DateTime? _selectedDate; // Declare a nullable DateTime variable

  // String dropdownvalue = Text('12345678',style: GoogleFonts.poppins(
  //                   // Replace 'YourFontFamily' with your desired font family
  //                   fontWeight: FontWeight.bold,
  //                   color: Color(0x8F7364E3), // Adjust the weight as needed
  //                 ),).toString();

  String dropdownvalue = '12345678';
  String? _selectedCollege;
  String? _selectedCourse;
  List<String>? _courseOptions;
  var cardid = [
    '12345678',
    '87654321',
  ];

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
          'Add Student',
          style: GoogleFonts.poppins(
            fontSize: 22, // Adjust the font size
            fontWeight: FontWeight.bold, // Adjust the font weight
            color: Color(0xff7364e3), // Adjust the text color
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40, 40, 40, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _nameController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Name',
                  labelStyle: GoogleFonts.poppins(
                    color: Color(0x8F7364E3), // Adjust the text color
                    fontWeight: FontWeight.bold, // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                style: TextStyle(
                    color: Color.fromARGB(255, 115, 100, 227),
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
                value: dropdownvalue,
                onChanged: (value) {
                  setState(() {
                    dropdownvalue != value;
                  });
                },
                items: cardid.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Card Id',
                  labelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3),
                  ),
                ),
                isExpanded:
                    true, // Set to true to show full text when dropdown is open
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _dobController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                readOnly: true, // Make the TextField read-only
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2012),
                    firstDate: DateTime(1995),
                    lastDate: DateTime(2012),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _selectedDate = pickedDate;
                      _dobController.text = DateFormat('dd-MM-yyyy')
                          .format(pickedDate); // Format the date without time
                    });
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Date of Birth',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _mobileController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Mobile Number',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: _selectedCollege,
                onChanged: (value) {
                  setState(() {
                    _selectedCollege = value;
                    if (_selectedCollege == 'Majlis Arts&Science College') {
                      _courseOptions = [
                        'BA Multimedia',
                        'BA Mass Communication & Journalism',
                        'BA Visual Communication',
                        'BA Functional English',
                        'BA Sociology',
                        'B Sc Physics',
                        'B Sc Chemistry',
                        'B Sc Computer Science',
                        'Bachelor of Computer Application (BCA)',
                        'B Sc Mathematics',
                        'B Sc Microbiology',
                        'Bachelor of Business Administration (BBA)',
                        'B Com. Finance',
                        'B Com. Computer Application',
                        'B Com. Travel and Tourism',
                        'B Com. Co-Operation',
                        'BA Graphic Designing and Animation',
                        'B.Des(Graphic and Communication Design)',
                        'MA English',
                        'M Com Finance',
                        'M Sc Physics',
                        'M Sc Chemistry',
                        'M Sc Mathematics',
                        'M Sc Microbiology',
                        'M Sc Computer Science',
                        'MA Sociology',
                      ];
                    } else if (_selectedCollege ==
                        'Majlis Polytechnic College') {
                      _courseOptions = [
                        'Diploma Automobile Engineering',
                        'Diploma Computer Engineering',
                        'Diploma Civil Engineering',
                        'Diploma Electrical and Electronics Engineering',
                        'Diploma Mechanical Engineering',
                      ];
                    }
                    _selectedCourse =
                        null; // Reset selected course when college changes
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text(
                      'Majlis Arts&Science College',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7364e3),
                      ),
                    ),
                    value: 'Majlis Arts&Science College',
                  ),
                  DropdownMenuItem(
                    child: Text(
                      'Majlis Polytechnic College',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7364e3),
                      ),
                    ),
                    value: 'Majlis Polytechnic College',
                  ),
                ],
                decoration: InputDecoration(
                  labelText: 'College',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                  enabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                ),
                style:
                    TextStyle(color: Color(0xff7364e3)), // Customize text color
              ),
            ),
            SizedBox(height: 10.0),
            if (_courseOptions != null)
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
                margin: EdgeInsets.symmetric(vertical: 3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedCourse,
                  onChanged: (value) {
                    setState(() {
                      _selectedCourse = value;
                    });
                  },
                  items: _courseOptions!.map((course) {
                    return DropdownMenuItem(
                      child: Text(
                        course,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff7364e3),
                        ),
                      ),
                      value: course,
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Course',
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Color(0x8F7364E3),
                    ),
                  ),
                  isExpanded:
                      true, // Set to true to show full text when dropdown is open
                ),
              ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _parentNameController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: "Parent's Name",
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _parentMobileController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: "Parent's Mobile Number",
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _addressController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Address',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _roomController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Room Number',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 30.0),
              margin: EdgeInsets.symmetric(vertical: 3.0),
              decoration: BoxDecoration(
                // Border color
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _passController,
                style: GoogleFonts.poppins(
                  // Replace 'YourFontFamily' with your desired font family
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7364E3), // Adjust the text color
                ),
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  labelText: 'Password',
                  labelStyle: GoogleFonts.poppins(
                    // Replace 'YourFontFamily' with your desired font family
                    fontWeight: FontWeight.bold,
                    color: Color(0x8F7364E3), // Adjust the weight as needed
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _uploadStudentDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7364e3),
                minimumSize: Size(double.infinity, 50), // Width and height
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Border radius
                ),
              ),
              child: Text(
                'Upload Student Details',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getNewStudentId() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('student').get();

    final int count = querySnapshot.docs.length;

    if (count == 0) {
      // If no documents exist, return the initial ID
      return 'STU1';
    } else {
      // Get the ID of the last document
      final String lastId = querySnapshot.docs[count - 1].id;
      final int lastIdNum = int.parse(lastId
          .substring(3)); // Extract the numeric part and convert to integer
      final int newIdNum = lastIdNum + 1; // Increment the ID
      return 'STU$newIdNum';
    }
  }

  Future<void> _uploadStudentDetails() async {
    // Check if any of the fields are empty
    if (_nameController.text.isEmpty ||
        _selectedDate == null ||
        _mobileController.text.isEmpty ||
        _selectedCollege == null ||
        _selectedCourse == null ||
        _parentNameController.text.isEmpty ||
        _parentMobileController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _passController.text.isEmpty ||
        _roomController.text.isEmpty) {
      // Show a SnackBar if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all inputs'),
        ),
      );
      return; // Exit the method if any field is empty
    }

    // Get new student ID
    final String studentId = await _getNewStudentId();

    // Save student details to Firestore with the generated ID and as document name
    await FirebaseFirestore.instance.collection('student').doc(studentId).set({
      'studentId': studentId, // Add student ID field
      'name': _nameController.text.trim(),
      'dob': DateFormat('dd-MM-yyyy').format(_selectedDate!),
      'mobile': _mobileController.text.trim(),
      'college': _selectedCollege,
      'course': _selectedCourse,
      'parentName': _parentNameController.text.trim(),
      'parentMobile': _parentMobileController.text.trim(),
      'address': _addressController.text.trim(),
      'roomNumber': _roomController.text.trim(),
      'password': _passController.text.trim(),
      'cardid': dropdownvalue.trim(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Student details uploaded successfully'),
        ),
      );
    }).whenComplete(() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
        (route) => false));

  }
}
