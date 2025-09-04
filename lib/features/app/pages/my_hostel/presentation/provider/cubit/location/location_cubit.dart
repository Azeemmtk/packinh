import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:packinh/core/services/geolocation_services.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LatLng position; // Changed to LatLng for flutter_map compatibility
  final String placeName;

  LocationLoaded(this.position, this.placeName);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}

class LocationCubit extends Cubit<LocationState> {
  final GeolocationService _geolocationService;

  LocationCubit(this._geolocationService) : super(LocationInitial());

  Future<void> selectLocation(LatLng selectedPosition) async {
    emit(LocationLoading());
    try {
      final placeName = await _geolocationService.getPlaceNameFromCoordinates(
        selectedPosition.latitude,
        selectedPosition.longitude,
      );
      emit(LocationLoaded(selectedPosition, placeName));
    } catch (e) {
      emit(LocationError('Error fetching place name: $e'));
    }
  }

  Future<void> fetchCurrentLocation() async {
    // Optional: Keep this for fallback or initial map centering
    emit(LocationLoading());
    try {
      final result = await _geolocationService.getCurrentLocation();
      if (result != null) {
        final latLng = LatLng(
          result['position'].latitude,
          result['position'].longitude,
        );
        emit(LocationLoaded(latLng, result['placeName']));
      } else {
        emit(LocationError('Failed to get current location'));
      }
    } catch (e) {
      emit(LocationError('Error fetching location: $e'));
    }
  }

  void initializeWithLocation(String placeName, double latitude, double longitude) {
    emit(LocationLoaded(
      LatLng(latitude, longitude),
      placeName,
    ));
  }
}