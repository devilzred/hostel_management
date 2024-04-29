import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveLog extends StatefulWidget {
  const LiveLog({super.key});

  @override
  State<LiveLog> createState() => _LiveLogState();
}

class _LiveLogState extends State<LiveLog> {
  var jsonData = '';
  bool _checkin = false;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('attendance');

  ScrollController controller = ScrollController();

  Future<String> NameFinder(String uid) async {
    CollectionReference students =
        FirebaseFirestore.instance.collection('student');

    QuerySnapshot querySnapshot =
        await students.where('cardid', isEqualTo: uid).get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      return document['name'];
    } else {
      return "Unknown";
    }
  }

  void _scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget getStatusIcon(int status) {
    if (status == 1) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else {
      return Icon(Icons.error, color: Colors.red);
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
          'Live Status',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                width: 160,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 2,
                      color: Color(0xff7364e3),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'UID',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          Text('STU10')
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Name:',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7364e3),
                            ),
                          ),
                          Flexible(child: Text('karthiktnsisaco',style:GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0)) ,)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.transfer_within_a_station_outlined,
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          _checkin
                              ? Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.greenAccent,
                                  size: 60,
                                )
                              : Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.redAccent,
                                  size: 50,
                                )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
