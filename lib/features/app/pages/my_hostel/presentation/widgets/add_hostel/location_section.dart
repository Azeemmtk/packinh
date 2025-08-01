import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';

import '../../provider/cubit/location/location_cubit.dart';

class LocationSection extends StatelessWidget {
  final String? locationError;

  const LocationSection({
    super.key,
    this.locationError,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const CircularProgressIndicator(color: mainColor);
        } else if (state is LocationLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logos_google-maps.svg',
                    height: 30, // optional
                    width: 30, // optional
                  ),
                  width10,
                  Text(
                    'Location: ${state.placeName}',
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              if (locationError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    locationError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logos_google-maps.svg',
                    height: 30, // optional
                    width: 30, // optional
                  ),
                  width10,
                  TextButton(
                    onPressed: () => context.read<LocationCubit>().fetchCurrentLocation(),
                    child: const Text('Select location'),
                  ),
                ],
              ),
              if (locationError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    locationError!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}