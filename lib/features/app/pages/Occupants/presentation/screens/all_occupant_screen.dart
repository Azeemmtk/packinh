import 'package:flutter/material.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';

import '../../../../../../core/constants/const.dart';
import '../widgets/occupant_card_widget.dart';

class AllOccupantScreen extends StatelessWidget {
  const AllOccupantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBarWidget(
            title: 'Summit hostel',
          ),
          height10,
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return OccupantCardWidget();
              },
              separatorBuilder: (context, index) => height20,
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}
