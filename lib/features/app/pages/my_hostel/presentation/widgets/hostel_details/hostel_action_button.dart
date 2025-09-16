import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/entity/hostel_entity.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';

import '../../provider/bloc/my_hostel/my_hostel_bloc.dart';
import '../../provider/bloc/my_hostel/my_hostel_event.dart';
import '../../provider/bloc/my_hostel/my_hostel_state.dart';
import '../../screens/hostel_edit_screen.dart';

class HostelActionButtons extends StatelessWidget {
  final HostelEntity hostel;
  const HostelActionButtons({super.key, required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomGreenButtonWidget(
          name: 'Edit details',
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => HostelEditScreen(hostel: hostel),
              ),
            );
            if (result == true) {
              context.read<MyHostelsBloc>().add(
                FetchMyHostels(CurrentUser().uId ?? ''),
              );
            }
          },
        ),
        height20,
        BlocConsumer<MyHostelsBloc, MyHostelsState>(
          listener: (context, state) {
            if (state is MyHostelsDeleted) {
              Navigator.pop(context);
              context.read<MyHostelsBloc>().add(
                FetchMyHostels(CurrentUser().uId ?? ''),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Hostel deleted successfully')),
              );
            } else if (state is MyHostelsDeletedError) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(text: state.message)
              );
            }
          },
          builder: (context, state) {
            return CustomGreenButtonWidget(
              name: 'Delete',
              color: Colors.redAccent,
              onPressed: () {
                Navigator.pop(context);
                context.read<MyHostelsBloc>().add(
                  DeleteHostelEvent(hostelId: hostel.id),
                );
              },
              isLoading: state is MyHostelsLoading,
            );
          },
        ),
      ],
    );
  }
}
