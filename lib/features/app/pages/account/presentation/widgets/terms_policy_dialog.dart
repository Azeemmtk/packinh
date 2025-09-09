import 'package:flutter/material.dart';
import '../../../../../../core/constants/colors.dart';

class TermsPolicyDialog extends StatelessWidget {
  const TermsPolicyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Terms & Privacy Policy',
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
              'Terms of Use',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'By using the Hostel Owner App, you agree to the following terms:\n'
                  '- You are responsible for the accuracy of hostel information, including location, facilities, and pricing.\n'
                  '- You must ensure that all financial data (e.g., rent, expenses) is accurate and up-to-date.\n'
                  '- The app is intended for lawful use in managing hostel properties. Any misuse may result in account suspension.\n'
                  '- The HostelApp Team reserves the right to update these terms at any time.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Privacy Policy',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'We value your privacy and are committed to protecting your data:\n'
                  '- **Data Collection**: We collect hostel details, financial data, and user information to provide app functionality.\n'
                  '- **Data Use**: Your data is used to manage hostels, track finances, and generate reports. It is not shared with third parties except as required by law.\n'
                  '- **Data Security**: We implement industry-standard measures to protect your data, but no system is completely secure.\n'
                  '- **Contact**: For privacy concerns, email support@hostelapp.com.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            const Text(
              'Last Updated: September 9, 2025',
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