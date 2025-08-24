import 'package:flutter/material.dart';
import 'package:packinh/features/app/pages/Occupants/presentation/screens/all_occupant_screen.dart';
import 'package:packinh/features/app/pages/Occupants/presentation/widgets/hostel_card_widget.dart';
import 'package:packinh/features/app/pages/Occupants/presentation/widgets/occupant_card_widget.dart';

import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';

class OccupantsScreen extends StatelessWidget {
  const OccupantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBarWidget(
          title: 'Occupants',
          enableChat: true,
        ),
        height10,
        TitleTextWidget(title: '  Your Hostels'),
        height10,
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return HostelCardWidget();
            },
            separatorBuilder: (context, index) => height20,
            itemCount: 6,
          ),
        ),
      ],
    );
  }
}
