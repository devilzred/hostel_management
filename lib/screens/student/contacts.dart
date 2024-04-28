import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: ImportantContactsScreen(),
  ));
}

class ImportantContactsScreen extends StatelessWidget {
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
          'Important Contacts',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
        children: [
          ContactCard(
            name: 'Hostel Warden',
            phoneNumber: '1233 456 7890',
          ),
          ContactCard(
            name: 'Majlis Administration',
            phoneNumber: '0494 264 4286',
          ),
          ContactCard(
            name: 'Majlis Arts College',
            phoneNumber: '0494 264 3970',
          ),
          ContactCard(
            name: 'Majlis Polytechnic College',
            phoneNumber: '+91 9447 845 634',
          ),
          ContactCard(
            name: 'Police Station',
            phoneNumber: '+91 9497 987 169',
          ),
          ContactCard(
            name: 'Fire Force',
            phoneNumber: '0483 273 4800',
          ),
          ContactCard(
            name: 'Women Safety',
            phoneNumber: '0483 295 0084',
          ),
          ContactCard(
            name: 'Food & Safety',
            phoneNumber: '0483 273 2121',
          ),
          ContactCard(
            name: 'App Developer',
            phoneNumber: '+91 8281 529 106',
          ),
        ],
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String name;
  final String phoneNumber;

  const ContactCard({
    required this.name,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          name,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: Color(0xff7364e3),
          ),
        ),
        subtitle: Text(
          phoneNumber,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Color(0xff7364e3),
          ),
        ),
        leading: Icon(
          Icons.contact_phone,
          size: 50,
          color: Color(0xff7364e3),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.copy_rounded, // Copy icon
            color: Color(0xff7364e3),
          ),
          onPressed: () {
            _copyToClipboard(context, phoneNumber);
          },
        ),
      ),
    );
  }

  _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied $text to clipboard'),
      ),
    );
  }
}


