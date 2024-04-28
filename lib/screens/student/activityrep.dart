import 'package:flutter/material.dart';

class DailyActivityReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Activity Report'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Activity Report',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Date: February 22, 2024', // You can dynamically change the date
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tasks Completed:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildTaskItem('Task 1', 'Completed'),
            _buildTaskItem('Task 2', 'In Progress'),
            _buildTaskItem('Task 3', 'Not Started'),
            // Add more task items as needed
            SizedBox(height: 20),
            Text(
              'Notes:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vel sem eu nisi pulvinar convallis vel ut nisi. Nulla facilisi. Maecenas in vehicula arcu. Mauris ullamcorper nisi eget diam lobortis luctus.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String taskName, String status) {
    return Row(
      children: [
        Icon(
          status == 'Completed' ? Icons.check_circle : Icons.radio_button_unchecked,
          color: status == 'Completed' ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 10),
        Text(
          taskName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text(
          status,
          style: TextStyle(
            fontSize: 16,
            color: status == 'Completed' ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DailyActivityReport(),
  ));
}
