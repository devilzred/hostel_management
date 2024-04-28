import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(MaterialApp(
    home: FoodMenu(),
  ));
}

class FoodMenu extends StatefulWidget {
  @override
  _FoodMenuState createState() => _FoodMenuState();
}

class _FoodMenuState extends State<FoodMenu> {
  bool _isLoading = true;

  late List<QueryDocumentSnapshot> _foodMenuDocs;

  @override
  void initState() {
    super.initState();
    fetchFoodMenu();
  }

  Future<void> fetchFoodMenu() async {
    final QuerySnapshot foodMenuSnapshot =
        await FirebaseFirestore.instance.collection('foodmenu').get();
    setState(() {
      _foodMenuDocs = foodMenuSnapshot.docs;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
          '7-Day Food Menu',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: _isLoading ? _buildSkeleton() : _buildContent(),
    );
  }

  Widget _buildSkeleton() {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      children: [
        for (int i = 0; i < 7; i++)
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildMealSectionSkeleton(),
                          _buildMealSectionSkeleton(),
                          _buildMealSectionSkeleton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMealSectionSkeleton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80.0,
          height: 20.0,
          color: Colors.white,
        ),
        SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 16.0,
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Container(
              width: 100.0,
              height: 16.0,
              color: Colors.white,
            ),
            SizedBox(height: 5),
            Container(
              width: 100.0,
              height: 16.0,
              color: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildContent() {
    // Sort the _foodMenuDocs list based on the day
    _foodMenuDocs.sort((a, b) {
      // Define a list of weekdays in order
      List<String> weekdays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
      ];
      // Compare the index of each day in the weekdays list
      return weekdays.indexOf(a.id) - weekdays.indexOf(b.id);
    });

    return ListView(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      children: [
        for (var doc in _foodMenuDocs)
          DailyFoodTable(
            day: doc.id,
            breakfast: doc['breakfast'] != null ? List<String>.from(doc['breakfast']) : [],
            noon: doc['noon'] != null ? List<String>.from(doc['noon']) : [],
            dinner: doc['dinner'] != null ? List<String>.from(doc['dinner']) : [],
          ),
      ],
    );
  }
}

class DailyFoodTable extends StatelessWidget {
  final String day;
  final List<String> breakfast;
  final List<String> noon;
  final List<String> dinner;

  const DailyFoodTable({
    Key? key,
    required this.day,
    required this.breakfast,
    required this.noon,
    required this.dinner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Card(
        elevation: 0, // Add elevation for box shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Add rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day + ':',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff7364e3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildMealSection('Breakfast', breakfast),
                  _buildMealSection('Noon', noon),
                  _buildMealSection('Dinner', dinner),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Color(0xff7364e3),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (String foodItem in items)
              Text(
                foodItem,
                style: GoogleFonts.poppins(),
              ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
