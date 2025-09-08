import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../auth/presentation/provider/bloc/auth_bloc.dart';
import '../widgets/logout_button_widget.dart';
import '../widgets/profile_list_items.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const list = [
      'Profile',
      'reports',
      'Add Compliant',
      'Help',
      'About',
      'Terms & Policy',
    ];
    return BlocListener<AuthBloc, dynamic>(
      listener: (context, state) {

      },
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarWidget(
              title: 'Account',
              enableChat: true,
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.5,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ProfileListItems(
                          text: list[index],
                          selectedIndex: index,
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: list.length,
                    ),
                  ),
                  LogoutButtonWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
