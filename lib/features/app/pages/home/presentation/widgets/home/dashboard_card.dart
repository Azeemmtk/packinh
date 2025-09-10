import 'package:flutter/material.dart';
import 'package:packinh/features/app/pages/home/presentation/widgets/home/build_status_card.dart';

import '../../../../../../../core/constants/const.dart';
import '../../../domain/entity/dashboard_data.dart';

class DashboardCards extends StatelessWidget {
  final DashboardData data;
  const DashboardCards({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First row
        Row(
          children: [
            Expanded(child: BuildStatusCard(icon: Icons.people_alt_outlined, value: data.occupantsCount.toString(), label: 'Occupants')),
            width10,
            Expanded(child: BuildStatusCard(icon: Icons.person, value: data.rentPaidCount.toString(), label: 'Rent paid')),
          ],
        ),
        height10,
        // Second row
        Row(
          children: [
            Expanded(child: BuildStatusCard(icon: Icons.person, value: data.rentPendingCount.toString(), label: 'Rent pending', pending: true)),
            width10,
            Expanded(child: BuildStatusCard(icon: Icons.money, value: data.receivedAmount.toString(), label: 'Received amount')),
          ],
        ),
        height10,
        // Centered card
        BuildStatusCard(icon: Icons.money, value: data.pendingAmount.toString(), label: 'Pending amount', pending: true),
      ],
    );
  }
}
