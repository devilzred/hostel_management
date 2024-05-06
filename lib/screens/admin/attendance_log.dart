import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AttendenceLog extends StatefulWidget {
  const AttendenceLog({Key? key});

  @override
  State<AttendenceLog> createState() => _AttendenceLogState();
}

class _AttendenceLogState extends State<AttendenceLog> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('attendance');

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<String> getName(String uid) async {
    // Implement your logic to fetch the name from Firestore or any other source
    return "Name: John Doe";
  }

  Color getStatusColor(int status) {
    return status == 1 ? Color.fromARGB(255, 193, 242, 147) : Color.fromARGB(255, 244, 186, 168);
  }

  Widget getStatusIcon(int status) {
    return status == 1
        ? SvgPicture.asset(
            "assets/images/login-svgrepo-com.svg",
            width: 30,
            color: Color.fromARGB(255, 10, 191, 16),
          )
        : SvgPicture.asset(
            "assets/images/logout-svgrepo-com.svg",
            width: 30,
            color: Color.fromARGB(255, 237, 13, 13),
          );
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
          'Attendance Log',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
            child: FirebaseAnimatedList(
              query: _databaseReference,
              itemBuilder: (
                BuildContext context,
                DataSnapshot snapshot,
                Animation<double> _animation,
                int index,
              ) {
                Map attendance = snapshot.value as Map;
                int status = attendance['status'] as int;
          
                return ListTile(
                  tileColor: getStatusColor(status),
                  leading: getStatusIcon(status),
                  title: FutureBuilder<String>(
                    future: getName(attendance['uid'].toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('Fetching...');
                      } else {
                        return Text(
                          snapshot.data ?? 'Unknown',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                  subtitle: Text("Card ID: ${attendance['uid'].toString()}"),
                  trailing: Text(attendance['time'].toString()),
                );
              },
            ),
          ),
    );
  }

}
