import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/utils/validators.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:uuid/uuid.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/cloudinary_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/cubit/location/location_cubit.dart';

import '../../provider/bloc/add_hostel/add_hostel_bloc.dart';
import '../../provider/bloc/add_hostel/add_hostel_event.dart';

class HostelFormController {
  final TextEditingController facilityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> _facilities = [];
  List<String> get facilities => _facilities;

  final List<Map<String, dynamic>> _rooms = [];
  List<Map<String, dynamic>> get rooms => _rooms;

  String? _nameError;
  String? get nameError => _nameError;
  String? _contactError;
  String? get contactError => _contactError;
  String? _descriptionError;
  String? get descriptionError => _descriptionError;
  String? _facilityError;
  String? get facilityError => _facilityError;
  String? _locationError;
  String? get locationError => _locationError;
  String? _roomsError;
  String? get roomsError => _roomsError;
  String? _imageError;
  String? get imageError => _imageError;

  File? _mainImage;
  File? get mainImage => _mainImage;
  List<File?> _smallImages = [null, null, null];
  List<File?> get smallImages => _smallImages;

  String? _mainImageUrl;
  String? get mainImageUrl => _mainImageUrl;
  List<String> _smallImageUrls = [];
  List<String> get smallImageUrls => _smallImageUrls;

  String? _mainImagePublicId;
  String? get mainImagePublicId => _mainImagePublicId;
  List<String> _smallImagePublicIds = [];
  List<String> get smallImagePublicIds => _smallImagePublicIds;

  void addFacility() {
    final facility = facilityController.text.trim();
    if (facility.isNotEmpty) {
      _facilities.add(facility);
      facilityController.clear();
      _facilityError = null;
    } else {
      _facilityError = 'Facility name cannot be empty';
    }
  }

  void removeFacility(String facility) {
    _facilities.remove(facility);
    if (_facilities.isEmpty) {
      _facilityError = 'At least one facility is required';
    }
  }

  void addRoom(String type, int count, double rate) {
    _rooms.add({
      'type': type,
      'count': count,
      'rate': rate,
    });
    _roomsError = null;
  }

  void removeRoom(Map<String, dynamic> room) {
    _rooms.remove(room);
    if (_rooms.isEmpty) {
      _roomsError = 'At least one room is required';
    }
  }

  void setMainImage(File? image) {
    _mainImage = image;
    _imageError = image == null ? 'Main image is required' : null;
  }

  void setSmallImages(List<File?> images) {
    _smallImages = images;
  }

  void clearNameError() => _nameError = null;
  void clearContactError() => _contactError = null;
  void clearDescriptionError() => _descriptionError = null;
  void clearFacilityError() => _facilityError = null;
  void clearLocationError() => _locationError = null;
  void clearRoomsError() => _roomsError = null;
  void clearImageError() => _imageError = null;

  Future<bool> uploadImages(BuildContext context) async {
    try {
      final cloudinaryDataSource = getIt<CloudinaryDataSource>();
      final images = [_mainImage, ..._smallImages.where((img) => img != null)];
      if (images.isEmpty) {
        _imageError = 'At least one image is required';
        return false;
      }
      final results = await cloudinaryDataSource.uploadImages(images);

      _mainImageUrl = results.isNotEmpty ? results[0]['secureUrl'] : null;
      _mainImagePublicId = results.isNotEmpty ? results[0]['publicId'] : null;
      _smallImageUrls = results.length > 1 ? results.sublist(1).map((r) => r['secureUrl'] as String).toList() : [];
      _smallImagePublicIds = results.length > 1 ? results.sublist(1).map((r) => r['publicId'] as String).toList() : [];

      if (_mainImageUrl == null) {
        _imageError = 'Failed to upload main image';
        return false;
      }
      return true;
    } catch (e) {
      debugPrint('Image upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload images: $e')),
      );
      return false;
    }
  }

  void submitForm(BuildContext context, GlobalKey<FormState> formKey) async {
    final locationState = context.read<LocationCubit>().state;
    final errors = Validation.validateHostelForm(
      name: nameController.text,
      contact: contactNumberController.text,
      description: descriptionController.text,
      facilities: _facilities,
      locationLoaded: locationState is LocationLoaded,
    );

    _nameError = errors['name'];
    _contactError = errors['contact'];
    _descriptionError = errors['description'];
    _facilityError = errors['facilities'];
    _locationError = errors['location'];
    _roomsError = _rooms.isEmpty ? 'At least one room is required' : null;

    if (formKey.currentState!.validate() &&
        _facilities.isNotEmpty &&
        locationState is LocationLoaded &&
        _roomsError == null &&
        _imageError == null) {
      context.read<AddHostelBloc>().add(const StartHostelSubmissionEvent());
      final uploadSuccess = await uploadImages(context);
      if (uploadSuccess) {
        final hostel = HostelEntity(
          id: const Uuid().v4(),
          name: nameController.text,
          placeName: (locationState as LocationLoaded).placeName,
          latitude: locationState.position.latitude,
          longitude: locationState.position.longitude,
          contactNumber: contactNumberController.text,
          description: descriptionController.text,
          facilities: _facilities,
          rooms: _rooms,
          ownerId: CurrentUser().uId ?? '',
          ownerName: '',
          mainImageUrl: _mainImageUrl,
          mainImagePublicId: _mainImagePublicId,
          smallImageUrls: _smallImageUrls,
          smallImagePublicIds: _smallImagePublicIds,
          createdAt: DateTime.now(),
          approved: false, // New field, default to false
        );

        context.read<AddHostelBloc>().add(SubmitHostelEvent(hostel));
        context.read<MyHostelsBloc>().add(FetchMyHostels(CurrentUser().uId?? ''));
      } else {
        context.read<AddHostelBloc>().add(AddHostelErrorEvent('Please fix image errors'));
      }
    } else {
      context.read<AddHostelBloc>().add(const AddHostelErrorEvent('Please fix form errors'));
    }
  }

  void dispose() {
    facilityController.dispose();
    nameController.dispose();
    contactNumberController.dispose();
    descriptionController.dispose();
  }
}