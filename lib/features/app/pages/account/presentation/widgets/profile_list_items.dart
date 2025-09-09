import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/account/presentation/screens/expense_screen.dart';
import 'package:packinh/features/app/pages/account/presentation/screens/report_screen.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../auth/presentation/provider/bloc/auth_bloc.dart';
import '../screens/profile_screen.dart';

class ProfileListItems extends StatelessWidget {
  const ProfileListItems(
      {super.key, required this.text, required this.selectedIndex});

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
        }
        if (text == 'reports') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportScreen(),
            ),
          );
        }

        if (text == 'Add Expense') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ExpenseScreen(),
            ),
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
                  color: text != 'Log out' ? headingTextColor : Colors.red),
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
