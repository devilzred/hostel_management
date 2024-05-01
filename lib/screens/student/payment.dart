import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/main.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color(0xFFF0F0F0),
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
            icon: Icon(Icons.sort, color: Color(0xff7364e3), size: 40),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff7364e3), width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFFAFAFA),
      body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFF0F0F0), Color(0xFFFAFAFA)],
                    stops: [0.3, 0.9],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: CustomPaint(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 130, 30, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Details',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 30),
          Container(
      width: 600,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff7364e3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total estimated bill',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Color(0xff7364e3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your total bill of November month:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B9B9B),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '₹',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff7364e3),
                    ),
                  ),
                  Text(
                    '5100',
                    style: GoogleFonts.ultra(
                      fontSize: 48,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7364e3),
                    ),
                  ),
                  Text(
                    '/-',
                    style: GoogleFonts.ultra(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color(0xff7364e3),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Add your Pay Now button functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7364e3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Pay Now',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
                      ),
                        SizedBox(height: 30),
                        Text(
                          'Payment History',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 30),
                        _buildPaymentHistory('September'),
                        SizedBox(height: 30),
                        _buildPaymentHistory('August'),
                        SizedBox(height: 30),
                        _buildPaymentHistory('July'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/mainlogo.png',
                      height: 40,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Home',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                _buildDrawerItem(
                  text: 'Payments',
                  icon: Icons.attach_money_rounded,
                  onTap: () {
                    // Add functionality for Payment screen
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Resident',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.hotel,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for Resident screen
                  },
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 40),
                _buildDrawerItem(
                  text: 'Sign Out',
                  icon: Icons.exit_to_app,
                  onTap: () {
                    // Navigate to another page (here a simple message is shown)
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  
  Widget _buildPaymentHistory(String month) {
    return Container(
      width: 600,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff7364e3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.print_rounded,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                month,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: Color(0xff7364e3),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your total bill of $month month:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9B9B9B),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Add your Pay Now button functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff7364e3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Print Receipt',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({String text = "", IconData icon = Icons.error, required void Function() onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff7364e3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          text,
          style: GoogleFonts.poppins(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: Icon(
          icon,
          color: Color(0xFFFFFFFF),
        ),
        onTap: onTap,
      ),
    );
  }
}
