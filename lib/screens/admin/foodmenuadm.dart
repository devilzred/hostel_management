import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodMenuUpload extends StatefulWidget {
  @override
  _FoodMenuUploadState createState() => _FoodMenuUploadState();
}

class _FoodMenuUploadState extends State<FoodMenuUpload> {
  final List<TextEditingController> _breakfastControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> _noonControllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final List<TextEditingController> _dinnerControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedDay = 'Monday'; 

  Future<void> _uploadMenu(String day) async {
    try {
      await _firestore.collection('foodmenu').doc(day).set({
        'breakfast': _breakfastControllers.map((controller) => controller.text).toList(),
        'noon': _noonControllers.map((controller) => controller.text).toList(),
        'dinner': _dinnerControllers.map((controller) => controller.text).toList(),
      });

      // Clear the text fields after uploading
      _breakfastControllers.forEach((controller) => controller.clear());
      _noonControllers.forEach((controller) => controller.clear());
      _dinnerControllers.forEach((controller) => controller.clear());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Menu uploaded successfully!'),
        ),
      );
    } catch (e) {
      print('Error uploading menu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload menu. Please try again later.'),
        ),
      );
    }
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
            Icons.navigate_before_rounded,
            size: 35,
            color: Color(0xff7364e3),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Upload Food Menu',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(40, 40, 40, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select a Day:',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: _selectedDay,
              items: <String>[
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday',
                'Saturday',
                'Sunday',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDay = newValue!;
                });
              },
            ),
            SizedBox(height: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Breakfast:',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: List.generate(
                    _breakfastControllers.length,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
                      margin: EdgeInsets.symmetric(vertical: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: Color(0xFF7364E3),
                          width: 2,
                        ),
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
                        controller: _breakfastControllers[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7364E3),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Item ${index + 1}',
                          labelStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 115, 100, 227),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Noon:',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: List.generate(
                    _noonControllers.length,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
                      margin: EdgeInsets.symmetric(vertical: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: Color(0xFF7364E3),
                          width: 2,
                        ),
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
                        controller: _noonControllers[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7364E3),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Item ${index + 1}',
                          labelStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 115, 100, 227),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dinner:',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Column(
                  children: List.generate(
                    _dinnerControllers.length,
                    (index) => Container(
                      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
                      margin: EdgeInsets.symmetric(vertical: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: Color(0xFF7364E3),
                          width: 2,
                        ),
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
                        controller: _dinnerControllers[index],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7364E3),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Item ${index + 1}',
                          labelStyle: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 115, 100, 227),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                // Check if any input field is empty
                if (_breakfastControllers.any((controller) => controller.text.isEmpty) ||
                    _noonControllers.any((controller) => controller.text.isEmpty) ||
                    _dinnerControllers.any((controller) => controller.text.isEmpty)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please fill all inputs'),
                    ),
                  );
                  return; // Exit the function early
                }

                // All inputs are filled, proceed with menu upload
                await _uploadMenu(_selectedDay);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff7364e3),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Upload Menu',
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
}

