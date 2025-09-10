import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/features/app/pages/account/presentation/widgets/profile_avathar.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/details_row_widget.dart';
import '../../../../../auth/data/model/user_model.dart';
import '../provider/bloc/profile/profile_bloc.dart';
import '../../../../../../core/services/current_user.dart';
import '../screens/edit_profile_Screen.dart';

class ProfileContent extends StatelessWidget {
  final UserModel user;
  const ProfileContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileAvatar(photoUrl: user.photoURL),
          SizedBox(height: height * 0.02),

          DetailsRowWidget(title: 'Display Name', value: user.displayName ?? '.....', isBold: true),
          const Divider(),
          DetailsRowWidget(title: 'Email', value: user.email ?? '.....'),
          const Divider(),
          DetailsRowWidget(title: 'Phone', value: user.phone ?? '.....'),
          const Divider(),
          DetailsRowWidget(title: 'Name', value: user.displayName ?? 'null'),
          const Divider(),
          DetailsRowWidget(title: 'Age', value: user.age?.toString() ?? '.....'),
          const Divider(),
          DetailsRowWidget(title: 'Address', value: user.address ?? '.....'),
          const Divider(),
          DetailsRowWidget(title: 'Role', value: user.role),
          const Divider(),
          DetailsRowWidget(title: 'Wallet Balance', value: user.walletBalance?.toString() ?? 'null'),

          SizedBox(height: height * 0.02),

          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
              );

              if (result == true) {
                context.read<ProfileBloc>()
                  ..add(LoadProfileEvent(CurrentUser().uId!));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: mainColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
            ),
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
