import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/features/app/pages/home/presentation/widgets/build_status_card.dart';
import '../widgets/home_custom_appbar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const HomeCustomAppbarWidget(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    BuildStatusCard(
                      icon: Icons.people_alt_outlined,
                      value: '20',
                      label: 'Occupants',
                    ),
                    BuildStatusCard(
                      icon: Icons.person,
                      value: '400',
                      label: 'Rent paid',
                    ),
                    BuildStatusCard(
                      icon: Icons.person,
                      value: '20',
                      label: 'Rent pending',
                      pending: true,
                    ),
                    BuildStatusCard(
                      icon: Icons.money,
                      value: '40000',
                      label: 'Received amount',
                    ),
                    BuildStatusCard(
                      icon: Icons.money,
                      value: '20000',
                      label: 'Pending amount',
                      pending: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}