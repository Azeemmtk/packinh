import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_app_bar_widget.dart';

class OccupantsScreen extends StatelessWidget {
  const OccupantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomAppBarWidget(title: 'Occupants', enableChat: true,)],
    );
  }
}
