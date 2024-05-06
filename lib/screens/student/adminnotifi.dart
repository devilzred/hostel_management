import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotifiScrn extends StatefulWidget {
  const NotifiScrn({Key? key});

  @override
  State<NotifiScrn> createState() => _NotificationAdminState();
}

class _NotificationAdminState extends State<NotifiScrn> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime? _selectedDate;

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
          'Notifications',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                  );
                });
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF5F0FF),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('notifications').snapshots(),
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
                    documents.sort((a, b) => b['date'].compareTo(a['date']));

                    if (_selectedDate != null) {
                      documents = documents
                          .where((doc) =>
                              _isSameDate(doc['date'].toDate(), _selectedDate!))
                          .toList();
                    }

                    return ListView.separated(
                      itemCount: documents.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = documents[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color(0xff7364e3),
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            document['title'] ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            _formatDate(document['date']),
                          ),
                          onTap: () {
                            _showDetailsDialog(context, document);
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

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _formatDate(dynamic date) {
    if (date is Timestamp) {
      return DateFormat.yMMMMd().add_jm().format(date.toDate());
    }
    return '';
  }

  void _showDetailsDialog(BuildContext context, DocumentSnapshot document) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Title', document['title']),
              _buildDetailRow('Description', document['description']),
              _buildDetailRow('Date', _formatDate(document['date'])),
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
              value?.toString() ?? '',
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
