import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import '../../provider/cubit/location/location_cubit.dart';

class LocationSection extends StatefulWidget {
  final String? locationError;

  const LocationSection({
    super.key,
    this.locationError,
  });

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Trigger fetching current location when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationCubit>().fetchCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Location on Map',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: padding),
        SizedBox(
          height: 300, // Adjust map height as needed
          child: Stack(
            children: [
              BlocConsumer<LocationCubit, LocationState>(
                listener: (context, state) {
                  if (state is LocationLoaded) {
                    // Move map to the current location when LocationLoaded is emitted
                    _mapController.move(state.position, 13.0);
                  }
                },
                builder: (context, state) {
                  LatLng initialCenter = const LatLng(9.9312, 76.2673); // kochin
                  Marker? selectedMarker;

                  if (state is LocationLoaded) {
                    initialCenter = state.position;
                    selectedMarker = Marker(
                      point: state.position,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    );
                  }

                  return FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: initialCenter,
                      initialZoom: 13.0,
                      onTap: (tapPosition, point) {
                        context.read<LocationCubit>().selectLocation(point);
                      },
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'PackInhApp/1.0 (contact: aseemmtk@example.com)',
                      ),
                      if (selectedMarker != null)
                        MarkerLayer(
                          markers: [selectedMarker],
                        ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    context.read<LocationCubit>().fetchCurrentLocation();
                  },
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.my_location,
                    color: mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 8),
                child: CircularProgressIndicator(color: mainColor),
              );
            } else if (state is LocationLoaded) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/logos_google-maps.svg',
                      height: 30,
                      width: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Location: ${state.placeName}',
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is LocationError) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        if (widget.locationError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.locationError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}