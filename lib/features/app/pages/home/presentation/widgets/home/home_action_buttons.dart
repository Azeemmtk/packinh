import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';

import '../../../../account/presentation/screens/expense_screen.dart';
import '../../screen/room_availability_screen.dart';

class HomeActionButtons extends StatelessWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoomAvailabilityScreen())),
          style: ElevatedButton.styleFrom(backgroundColor: mainColor, foregroundColor: Colors.white),
          child: const Text("View Room Availability"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseScreen())),
          style: ElevatedButton.styleFrom(backgroundColor: mainColor, foregroundColor: Colors.white),
          child: const Text("View Expenses"),
        ),
      ],
    );
  }
}
