import 'package:flutter/material.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // First row: 2 cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            child: BuildStatusCard(
                              icon: Icons.people_alt_outlined,
                              value: '20',
                              label: 'Occupants',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            child: BuildStatusCard(
                              icon: Icons.person,
                              value: '400',
                              label: 'Rent paid',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Second row: 2 cards
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            child: BuildStatusCard(
                              icon: Icons.person,
                              value: '20',
                              label: 'Rent pending',
                              pending: true,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                            child: BuildStatusCard(
                              icon: Icons.money,
                              value: '40000',
                              label: 'Received amount',
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Third row: 1 card centered
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: FractionallySizedBox(
                            widthFactor: 0.5,
                            child: BuildStatusCard(
                              icon: Icons.money,
                              value: '20000',
                              label: 'Pending amount',
                              pending: true,
                            ),
                          ),
                        ),
                      ),
                    ),
                    height20,
                    Align(
                      alignment: Alignment.centerLeft,
                        child: TitleTextWidget(title: "Revenue"))
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