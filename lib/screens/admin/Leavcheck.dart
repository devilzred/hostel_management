import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LeaveNotify extends StatefulWidget {
  const LeaveNotify({Key? key});

  @override
  State<LeaveNotify> createState() => _NotificationAdminState();
}

class _NotificationAdminState extends State<LeaveNotify> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _stuidController = TextEditingController();
  String? _filterStuid;
      CollectionReference students =
      FirebaseFirestore.instance.collection('student');

  @override
  void dispose() {
    _stuidController.dispose();
    super.dispose();
  }

  Future<String> NameFinder(String uid) async {
    QuerySnapshot querySnapshot =
        await students.where('studentId', isEqualTo: uid).get();

    if (querySnapshot.docs.isNotEmpty) {
      var document = querySnapshot.docs.first;

      return document['name'];
    } else {
      return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 240, 240),
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
          'Leave Request',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _filterStuid = _stuidController.text.trim();
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF5F0FF), // Light purple background color
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _stuidController,
                decoration: InputDecoration(
                  labelText: 'Filter by STU ID',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _stuidController.clear();
                      setState(() {
                        _filterStuid = null;
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _filterStuid = value.trim();
                  });
                },
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('leavereq').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<DocumentSnapshot> documents = snapshot.data!.docs;
                    documents.sort((a, b) => b['date'].compareTo(a['date'])); // Sort documents by date in descending order

                    // Apply filter if _filterStuid is not null or empty
                    if (_filterStuid != null && _filterStuid!.isNotEmpty) {
                      documents = documents.where((doc) => doc['stuid'] == _filterStuid).toList();
                    }

                    return ListView.separated(
  itemCount: documents.length,
  separatorBuilder: (context, index) => Divider(), // Add a line between list items
  itemBuilder: (context, index) {
    DocumentSnapshot document = documents[index];
    return FutureBuilder(
      future: NameFinder(document['stuid'].toString()),
      builder: (BuildContext context, AsyncSnapshot<String> nameSnapshot) {
        if (nameSnapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            title: Text('Loading...'),
          );
        } else if (nameSnapshot.hasError) {
          return ListTile(
            title: Text('Error: ${nameSnapshot.error}'),
          );
        } else {
          return ListTile(
            title: Text(
              nameSnapshot.data ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Adjust the text size and weight
            ),
            subtitle: Text(document['leaveType'] ?? ''),
            onTap: () {
              _showDetailsDialog(context, document);
            },
          );
        }
      },
    );
  },
);

                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Leave Request Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('STU ID', document['stuid']),
              _buildDetailRow('Leave Type', document['leaveType']),
              _buildDetailRow('Start Date', document['startDate']),
              _buildDetailRow('End Date', document['endDate']),
              _buildDetailRow('Reason', document['reason']),
              // Add more fields here if needed
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }


Widget _buildDetailRow(String label, dynamic value) {
  String formattedValue = '';
  if (label == 'Start Date' || label == 'End Date') {
    formattedValue = DateFormat.yMMMMd().add_jm().format(value.toDate());
  } else {
    formattedValue = value?.toString() ?? '';
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label + ':',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            formattedValue,
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

}
