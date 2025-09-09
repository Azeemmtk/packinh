import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/account/presentation/screens/expense_screen.dart';
import 'package:packinh/features/app/pages/account/presentation/screens/report_screen.dart';
import 'package:packinh/features/app/pages/account/presentation/widgets/terms_policy_dialog.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../auth/presentation/provider/bloc/auth_bloc.dart';
import '../screens/profile_screen.dart';
import 'help_dialog.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems({
    super.key,
    required this.text,
    required this.selectedIndex,
  });

  final String text;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (text == 'Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(),
            ),
          );
        } else if (text == 'reports') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportScreen(),
            ),
          );
        } else if (text == 'Add Expense') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ExpenseScreen(),
            ),
          );
        } else if (text == 'Help') {
          showDialog(
            context: context,
            builder: (context) => const HelpDialog(),
          );
        } else if (text == 'About') {
          showDialog(
            context: context,
            builder: (context) => const AboutDialog(),
          );
        } else if (text == 'Terms & Policy') {
          showDialog(
            context: context,
            builder: (context) => const TermsPolicyDialog(),
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: padding),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: text != 'Log out' ? headingTextColor : Colors.red,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}