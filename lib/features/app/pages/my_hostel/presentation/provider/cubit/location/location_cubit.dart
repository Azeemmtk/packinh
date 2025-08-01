import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:packinh/core/services/geolocation_services.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GeolocationService geolocationService;

  LocationCubit(this.geolocationService) : super(LocationInitial());

  Future<void> fetchCurrentLocation() async {
    emit(LocationLoading());
    try {
      final locationData = await geolocationService.getCurrentLocation();
      if (locationData != null) {
        emit(LocationLoaded(
          locationData['placeName']! as String,
          locationData['position']! as Position,
        ));
      } else {
        emit( LocationError('Failed to get location'));
      }
    } catch (e) {
      emit(LocationError('Error fetching location: $e'));
    }
  }
}