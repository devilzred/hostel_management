import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageRoomsPage extends StatefulWidget {
  @override
  _ManageRoomsPageState createState() => _ManageRoomsPageState();
}

class _ManageRoomsPageState extends State<ManageRoomsPage> {
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
            Navigator.pop(context); // Navigate back
          },
        ),
        title: Text(
          'Manage Rooms',
          style: GoogleFonts.poppins(
            fontSize: 22, // Adjust the font size
            fontWeight: FontWeight.bold, // Adjust the font weight
            color: Color(0xff7364e3), // Adjust the text color
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30.0, bottom: 30.0), // Adjust padding
        child: FloatingActionButton(
                    
          onPressed: () {
            // Add functionality for the floating action button here
          },
          child: Icon(Icons.add_home_rounded,
          color: Color(0xff7364e3),),
        ),
      ),
    );
  }
}
