import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/services/geolocation_services.dart';
import 'package:packinh/core/widgets/custom_app_bar_widget.dart';
import 'package:packinh/core/widgets/custom_green_button_widget.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/update_hostel/update_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/cubit/location/location_cubit.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/hostel_details_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/image_section.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/room_details_section.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/widgets/add_hostel/hostel_form_controller.dart';

class HostelEditScreen extends StatefulWidget {
  final HostelEntity hostel;

  const HostelEditScreen({super.key, required this.hostel});

  @override
  State<HostelEditScreen> createState() => _HostelEditScreenState();
}

class _HostelEditScreenState extends State<HostelEditScreen> {
  final HostelFormController _formController = HostelFormController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _formController.initializeWithHostel(widget.hostel);
  }

  @override
  void dispose() {
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UpdateHostelBloc>()),
        BlocProvider(create: (context) => getIt<MyHostelsBloc>()),
        BlocProvider(
          create: (context) => LocationCubit(GeolocationService())
            ..initializeWithLocation(
              widget.hostel.placeName,
              widget.hostel.latitude,
              widget.hostel.longitude,
            ),
        ),
      ],
      child: BlocListener<UpdateHostelBloc, UpdateHostelState>(
        listener: (context, state) {
          if (state is UpdateHostelLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Updating hostel...')),
            );
          } else if (state is UpdateHostelSuccess) {
            // context.read<MyHostelsBloc>().add(FetchMyHostels(CurrentUser().uId ?? ''));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Hostel updated successfully!')),
            );
            Navigator.pop(context, true);
          } else if (state is UpdateHostelError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CustomAppBarWidget(title: 'Edit Hostel'),
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
                          initialMainImageUrl: widget.hostel.mainImageUrl,
                          initialSmallImageUrls: widget.hostel.smallImageUrls,
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
                        BlocBuilder<UpdateHostelBloc, UpdateHostelState>(
                          buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
                          builder: (context, state) {
                            return CustomGreenButtonWidget(
                              name: 'Update Hostel',
                              isLoading: state is UpdateHostelLoading,
                              onPressed: () => _formController.submitUpdateForm(context, _formKey, widget.hostel),
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