import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationAdmin extends StatefulWidget {
  const NotificationAdmin({super.key});

  @override
  State<NotificationAdmin> createState() => _NotificationAdminState();
}

class _NotificationAdminState extends State<NotificationAdmin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection('leavereq').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
  itemCount: snapshot.data?.docs.length ?? 0,
  itemBuilder: (context, index) {
    DocumentSnapshot? document = snapshot.data?.docs[index];
    if (document == null) {
      return SizedBox.shrink(); // Return an empty widget if document is null
    }
    return ListTile(
      title: Text(document['leaveType'] ?? ''),
      subtitle: Text(document['reason'] ?? ''),
      // You can customize the ListTile as per your requirement
    );
  },
);

          }
        },
      ),
    );
  }
}