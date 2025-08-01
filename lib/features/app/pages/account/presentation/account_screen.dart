import 'package:flutter/material.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomAppBarWidget(title: 'Accounts', enableChat: true,)],
    );
  }
}
