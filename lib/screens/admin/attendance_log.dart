import 'dart:convert';


import 'package:direct_flutter_sms/direct_flutter_sms.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/values.dart';

import './model/detailsClass.dart';

class AttendenceLog extends StatefulWidget {
  const AttendenceLog({super.key});

  @override
  State<AttendenceLog> createState() => _AttendenceLogState();
}

class _AttendenceLogState extends State<AttendenceLog> {
  var jsonData = '';

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.ref().child('/');

  List<Activity> _activityList = [];
  ScrollController controller = ScrollController();

  String nameFinder(String id) {
    final trimmedId = id.trim(); // Trim any extra spaces

    if (trimmedId == '63 E6 34 E6') {
      return "Tanvir Islam Robin";
    }
    if (trimmedId == "23 E6 9E E5") {
      return "Azrul Amaline";
    }
    if (trimmedId == "B3 A2 12 E6") {
      return "Salauddin Ahmed";
    }
    if (trimmedId == "C1 BE 9A 1C") {
      return "Rana Maitra";
    }
    if (trimmedId == "73 70 93 E5") {
      return "Mahbub Hasan Abid";
    }
    if (trimmedId == "F3 EC DE E5") {
      return "Toukir Ahmed";
    } else {
      return "Unknown";
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/');
    loadData();
    starCountRef.onValue.listen((DatabaseEvent event) async {
      final data = event.snapshot.value;


      print("---------------------- Listening");

      print(data);
      setState(() {
        jsonData = event.snapshot.value.toString();
      });
      print("-----------------------");
    });

    loadData();

    _databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final dynamic snapshotValue = event.snapshot.value;

        final res = snapshotValue["number"] as int?;
        final List<Activity> activities = [];

        if (res != null) {
          for (int xx = 0; xx <= res; xx++) {
            if (snapshotValue[xx.toString()]["RFID"] == null) {
              return;
            }
            print(snapshotValue[xx.toString()]["RFID"]);
            final activity = Activity.fromJson(
                snapshotValue[xx.toString()]["RFID"].toString(),
                snapshotValue[xx.toString()]["Permission"].toString(),
                snapshotValue[xx.toString()]["time"]);
            activities.add(activity);
          }
        }
        print(res);
        setState(() {
          _activityList = activities;
        });
        _scrollDown();
      }
      _scrollDown();
    });
  }

  // void loadData() async {
  //   DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/');
  //   final snp = await starCountRef.child('/').get();
  //   final snapshotValue = snp.value;
  //   if (snp.value != null) {
  //     final res = snapshotValue!["number"].toString();
  //     final List<Activity> activities = [];
  //     int range = int.parse(res);
  //     for (int xx = 0; xx < range; xx++) {
  //       if (snapshotValue[xx.toString()]["RFID"] == null) {
  //         return;
  //       }
  //       print(snapshotValue[xx.toString()]["RFID"]);
  //       final activity = Activity.fromJson(
  //           snapshotValue[xx.toString()]["RFID"].toString(),
  //           snapshotValue[xx.toString()]["Permission"].toString(),
  //           snapshotValue[xx.toString()]["time"]);
  //       activities.add(activity);
  //     }
  //     print(res);
  //     setState(() {
  //       _activityList = activities;
  //     });
  //     setState(() {
  //       jsonData = snp.value.toString();
  //     });
  //   }
  //   print(snp.value);
  // }

  void loadData() async {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('/');
    final snp = await starCountRef.child('/').get();
    final snapshotValue = snp.value;
    if (snapshotValue != null && snapshotValue is Map<dynamic, dynamic>) {
      final res = snapshotValue["number"].toString();
      final List<Activity> activities = [];
      int range = int.parse(res);
      for (int xx = 0; xx < range; xx++) {
        if (snapshotValue[xx.toString()] == null ||
            snapshotValue[xx.toString()]["RFID"] == null) {
          return;
        }
        print(snapshotValue[xx.toString()]["RFID"]);
        final activity = Activity.fromJson(
            snapshotValue[xx.toString()]["RFID"].toString(),
            snapshotValue[xx.toString()]["Permission"].toString(),
            snapshotValue[xx.toString()]["time"]);
        activities.add(activity);
      }
      print(res);
      setState(() {
        _activityList = activities;
      });
      setState(() {
        jsonData = snp.value.toString();
      });
    }
    print(snp.value);
  }

  void _scrollDown() {
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 8, 8, 8)),
      ),
      home: Scaffold(
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
          body: ListView.builder(
            controller: controller,
            shrinkWrap: true,
            itemCount: _activityList.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(nameFinder(_activityList[i].rfid).toString()),
                  subtitle: Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_activityList[i].time),
                        Text(_activityList[i].rfid.toString())
                      ],
                    ),
                  ),
                  trailing: Container(
                    width: 100,
                    child: Text(_activityList[i].permission),
                  ),
                ),
              );
            },
          )),
    );
  }
}
