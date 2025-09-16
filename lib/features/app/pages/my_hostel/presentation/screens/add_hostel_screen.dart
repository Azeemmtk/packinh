import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/services/geolocation_services.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/core/widgets/custom_snack_bar.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/cubit/location/location_cubit.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/hostel_details_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/hostel_form_controller.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/image_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/room_details_section.dart';
import '../../../../../../core/di/injection.dart';
import '../provider/bloc/add_hostel/add_hostel_bloc.dart';
import '../provider/bloc/add_hostel/add_hostel_state.dart';
import '../provider/bloc/my_hostel/my_hostel_bloc.dart';

class AddHostelScreen extends StatefulWidget {
  const AddHostelScreen({super.key});

  @override
  State<AddHostelScreen> createState() => _AddHostelScreenState();
}

class _AddHostelScreenState extends State<AddHostelScreen> {
  final HostelFormController _formController = HostelFormController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AddHostelBloc>()),
        BlocProvider(create: (context) => getIt<MyHostelsBloc>()),
        BlocProvider(create: (context) => LocationCubit(GeolocationService())),
      ],
      child: BlocListener<AddHostelBloc, AddHostelState>(
        listener: (context, state) {
          if (state is AddHostelLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(text: 'Adding hostel...'),
            );
          } else if (state is AddHostelSuccess) {
            Navigator.pop(context,true);
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(text: 'Hostel added successfully!'),
            );
          } else if (state is AddHostelError) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(text: state.message)
            );
          }
        },
        child: Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child:  CustomAppBarWidget(title: 'Add Hostel'),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HostelDetailsSection(
                          formController: _formController,
                          onErrorChanged: () => setState(() {}),
                        ),
                        SizedBox(height: padding * 2),
                        ImageSection(
                          onMainImageChanged: _formController.setMainImage,
                          onSmallImagesChanged: _formController.setSmallImages,
                        ),
                        SizedBox(height: padding * 2),
                        RoomDetailsSection(
                          rooms: _formController.rooms,
                          roomsError: _formController.roomsError,
                          onAddRoom: _formController.addRoom,
                          onRemoveRoom: _formController.removeRoom,
                          onErrorChanged: () => setState(() {}),
                        ),
                        SizedBox(height: padding * 2),
                        BlocBuilder<AddHostelBloc, AddHostelState>(
                          buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                          builder: (context, state) {
                            return CustomGreenButtonWidget(
                              name: 'Add Hostel',
                              isLoading: state is AddHostelLoading,
                              onPressed: () => _formController.submitForm(context, _formKey),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}