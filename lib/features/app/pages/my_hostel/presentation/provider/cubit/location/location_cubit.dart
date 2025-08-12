import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packinh/core/services/geolocation_services.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Position position;
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

  Future<void> fetchCurrentLocation() async {
    emit(LocationLoading());
    try {
      final result = await _geolocationService.getCurrentLocation();
      if (result != null) {
        emit(LocationLoaded(result['position'], result['placeName']));
      } else {
        emit(LocationError('Failed to get location'));
      }
    } catch (e) {
      emit(LocationError('Error fetching location: $e'));
    }
  }

  void initializeWithLocation(String placeName, double latitude, double longitude) {
    emit(LocationLoaded(
      Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      ),
      placeName,
    ));
  }
}