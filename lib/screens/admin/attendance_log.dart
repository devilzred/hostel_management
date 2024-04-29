import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendenceLog extends StatefulWidget {
  const AttendenceLog({super.key});

  @override
  State<AttendenceLog> createState() => _AttendenceLogState();
}

class _AttendenceLogState extends State<AttendenceLog> {
  var jsonData = '';

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

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    // Fetch data here
    // Once data is fetched, set _isLoading to false
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
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
          'Attendence Log',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loading indicator
            )
          : Container(
              height: double.infinity,
              child: FirebaseAnimatedList(
                query: _databaseReference,
                itemBuilder: (
                  BuildContext context,
                  DataSnapshot snapshot,
                  Animation<double> _scrollDown,
                  int index,
                ) {
                  Map attendance = snapshot.value as Map;
                  attendance['key'] = snapshot.key;
                  int status = attendance['status'] as int;

                  return ListTile(
                    trailing: Text(attendance['time'].toString()),
                    subtitle: Text(attendance['uid'].toString()),
                    title: FutureBuilder<String>(
                      future: NameFinder(attendance['uid'].toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading...'); // Placeholder while loading
                        } else {
                          return Text(snapshot.data ?? 'Unknown');
                        }
                      },
                    ),
                    leading: getStatusIcon(status),
                  );
                },
              ),
            ),
    );
  }
}
