import 'dart:ffi';

import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveLog extends StatefulWidget {
  const LiveLog({super.key});

  @override
  State<LiveLog> createState() => _LiveLogState();
}

class _LiveLogState extends State<LiveLog> {
  var jsonData = '';
  String message = '';

  late DatabaseReference _databaseReference;

  CollectionReference students =
      FirebaseFirestore.instance.collection('student');

  ScrollController controller = ScrollController();

  Future<String> NameFinder(String uid) async {
    QuerySnapshot querySnapshot =
        await students.where('cardid', isEqualTo: uid).get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      return document['name'];
    } else {
      return "Unknown";
    }
  }

  Future<String> STUIDFinder(String uid) async {
    QuerySnapshot querySnapshot =
        await students.where('cardid', isEqualTo: uid).get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      return document['studentId'];
    } else {
      return "Unknown";
    }
  }

  Future<String> ParentNum(String uid) async {
    QuerySnapshot querySnapshot =
        await students.where('cardid', isEqualTo: uid).get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      return document['parentMobile'];
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

  Widget getStatusIcon(status) {
    if (status == 1) {
      return Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      );
    } else {
      return Icon(
        Icons.cancel_outlined,
        color: Colors.redAccent,
        size: 60,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('users');
    students = FirebaseFirestore.instance.collection('student');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _listenForStatusChanges();
  }

  void _listenForStatusChanges() {
    _databaseReference.onValue.listen((event) async {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            event.snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) async {
          String uid = key.toString();
          String studentName = await NameFinder(uid);
          String number = await ParentNum(uid);
          int status = value as int;
          if (status == 0) {
            setState(() {
              message = '$studentName has been Checked out';
            });
          } else if (status == 1) {
            // Use 'else if' to ensure mutual exclusivity
            setState(() {
              message = '$studentName has Checked In';
            });
          }
          if (await _isPermissionGranted()) {
            if ((await _supportCustomSim)!) {
              _sendMessage(number, message, simSlot: 1);
            } else
              _sendMessage(number, message);
          } else
            _getPermission();
        });
      }
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
          'Live Status',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: FirebaseAnimatedList(
          query: _databaseReference,
          itemBuilder: (
            BuildContext context,
            DataSnapshot snapshot,
            Animation<double> _scrollDown,
            int index,
          ) {
            // Map live = snapshot.value as Map;
            // print(live);
            if (!snapshot.exists) {
              // While the future is loading, show the circular progress indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        width: 340,
                        height: 150,
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
                                    'UID : ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff7364e3),
                                    ),
                                  ),
                                  FutureBuilder<String>(
                                    future:
                                        STUIDFinder(snapshot.key.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                            'Loading...'); // Placeholder while loading
                                      } else {
                                        return Text(
                                          snapshot.data ?? 'Unknown',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Name : ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff7364e3),
                                    ),
                                  ),
                                  FutureBuilder<String>(
                                    future: NameFinder(snapshot.key.toString()),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                            'Loading...'); // Placeholder while loading
                                      } else {
                                        return Text(
                                          snapshot.data ?? 'Unknown',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.transfer_within_a_station_outlined,
                                    size: 60,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  getStatusIcon(snapshot.value)

                                  // _checkin
                                  //     ? Icon(
                                  //         Icons.check_circle_outline,
                                  //         color: Colors.green,
                                  //         size: 60,
                                  //       )
                                  //     : Icon(
                                  //         Icons.cancel_outlined,
                                  //         color: Colors.redAccent,
                                  //         size: 50,
                                  //       )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
          }),
    );
  }

  _getPermission() async => await [
        Permission.sms,
      ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;
}
