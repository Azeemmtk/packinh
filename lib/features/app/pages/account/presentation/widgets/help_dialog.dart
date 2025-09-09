import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Help',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: headingTextColor,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the Hostel Owner App! Below is a guide to help you use the app effectively:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '1. Managing Hostels:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              '- Add a new hostel by navigating to the "Add Hostel" section.\n'
                  '- Edit or delete existing hostels from the hostel management screen.\n'
                  '- Include details like hostel name, location, facilities, and rooms.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              '2. Viewing Occupants:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              '- Check the "Room Availability" section to see occupants in each hostel.\n'
                  '- View details like occupant count and room assignments.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              '3. Tracking Finances:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              '- Monitor received and pending rent amounts on the home screen.\n'
                  '- View expenses for each hostel in the "Add Expense" section.\n'
                  '- Check the financial overview graph for revenue, pending amounts, and expenses.\n'
                  '- See net profit or loss below the graph.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              '4. Generating Reports:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Text(
              '- Access detailed reports on occupancy, revenue, and expenses in the "Reports" section.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Need more help? Contact support at support@hostelapp.com.',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: TextStyle(color: mainColor),
          ),
        ),
      ],
    );
  }
}