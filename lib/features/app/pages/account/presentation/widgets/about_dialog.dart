import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class AboutDialog extends StatelessWidget {
  const AboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'About Hostel Owner App',
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
              'The Hostel Owner App is designed to help hostel owners manage their properties efficiently. '
                  'With this app, you can:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Add, edit, or delete hostels with details like location, facilities, and room configurations.\n'
                  '- Track occupants and room availability across your hostels.\n'
                  '- Monitor financials, including received rent, pending payments, and expenses.\n'
                  '- View a financial overview with graphs showing revenue, pending amounts, and expenses.\n'
                  '- Generate reports to analyze occupancy and financial performance.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version: 1.0.0',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Developed by: HostelApp Team\n'
                  'Contact: support@hostelapp.com',
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