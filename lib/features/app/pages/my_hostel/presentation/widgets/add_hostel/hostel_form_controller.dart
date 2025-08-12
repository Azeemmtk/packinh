import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packinh/core/di/injection.dart';
import 'package:packinh/core/services/current_user.dart';
import 'package:packinh/core/utils/validators.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_bloc.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/my_hostel/my_hostel_event.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/bloc/update_hostel/update_hostel_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:packinh/features/app/pages/my_hostel/data/dataSourse/cloudinary_data_source.dart';
import 'package:packinh/features/app/pages/my_hostel/domain/entity/hostel_entity.dart';
import 'package:packinh/features/app/pages/my_hostel/presentation/provider/cubit/location/location_cubit.dart';
import '../../../../../../../core/utils/enums.dart';
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
  List<File?> _smallImages = [null, null, null];
  String? _mainImageUrl;
  String? _mainImagePublicId;
  List<String> _smallImageUrls = ['', '', ''];
  List<String> _smallImagePublicIds = ['', '', ''];

  void addFacility() {
    final facility = facilityController.text.trim();
    if (facility.isNotEmpty && !_facilities.contains(facility)) {
      _facilities.add(facility);
      facilityController.clear();
      _facilityError = null;
    }
  }

  void removeFacility(String facility) {
    _facilities.remove(facility);
    _facilityError = _facilities.isEmpty ? 'At least one facility is required' : null;
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
    _roomsError = _rooms.isEmpty ? 'At least one room is required' : null;
  }

  void setMainImage(File? image) {
    _mainImage = image;
    _imageError = _mainImage == null && _mainImageUrl == null ? 'Main image is required' : null;
  }

  void setSmallImages(List<File?> images) {
    _smallImages = images;
  }

  void clearNameError() => _nameError = null;
  void clearContactError() => _contactError = null;
  void clearDescriptionError() => _descriptionError = null;

  Future<bool> uploadImages(BuildContext context) async {
    try {
      final cloudinary = getIt<CloudinaryDataSource>();
      if (_mainImage != null) {
        final result = await cloudinary.uploadImage([_mainImage]);
        if (result.isNotEmpty) {
          _mainImageUrl = result[0]['secureUrl'];
          _mainImagePublicId = result[0]['publicId'];
        } else {
          _imageError = 'Failed to upload main image';
          return false;
        }
      }
      final smallImagesToUpload = _smallImages.where((image) => image != null).toList();
      if (smallImagesToUpload.isNotEmpty) {
        final result = await cloudinary.uploadImage(smallImagesToUpload);
        for (var i = 0; i < smallImagesToUpload.length; i++) {
          _smallImageUrls[i] = result[i]['secureUrl']!;
          _smallImagePublicIds[i] = result[i]['publicId']!;
        }
      }
      return true;
    } catch (e) {
      _imageError = 'Image upload failed: $e';
      return false;
    }
  }

  Future<void> submitForm(BuildContext context, GlobalKey<FormState> formKey) async {
    final locationState = context.read<LocationCubit>().state;
    final errors = {
      'name': Validation.validateName(nameController.text),
      'contact': Validation.validatePhone(contactNumberController.text),
      'description': Validation.validateDescription(descriptionController.text),
      'facilities': _facilities.isEmpty ? 'At least one facility is required' : null,
      'location': locationState is LocationLoaded ? null : 'Location is required',
    };

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
          status: Status.pending,
        );

        context.read<AddHostelBloc>().add(SubmitHostelEvent(hostel));
        context.read<MyHostelsBloc>().add(FetchMyHostels(CurrentUser().uId ?? ''));
      } else {
        context.read<AddHostelBloc>().add(const AddHostelErrorEvent('Please fix image errors'));
      }
    } else {
      context.read<AddHostelBloc>().add(const AddHostelErrorEvent('Please fix form errors'));
    }
  }

  void initializeWithHostel(HostelEntity hostel) {
    nameController.text = hostel.name;
    contactNumberController.text = hostel.contactNumber;
    descriptionController.text = hostel.description;
    _facilities.addAll(hostel.facilities);
    _rooms.addAll(hostel.rooms);
    _mainImageUrl = hostel.mainImageUrl;
    _mainImagePublicId = hostel.mainImagePublicId;
    _smallImageUrls = hostel.smallImageUrls.length > 3
        ? hostel.smallImageUrls.sublist(0, 3)
        : List<String>.filled(3, '').asMap().map((i, url) => MapEntry(i, i < hostel.smallImageUrls.length ? hostel.smallImageUrls[i] : '')).values.toList();
    _smallImagePublicIds = hostel.smallImagePublicIds.length > 3
        ? hostel.smallImagePublicIds.sublist(0, 3)
        : List<String>.filled(3, '').asMap().map((i, id) => MapEntry(i, i < hostel.smallImagePublicIds.length ? hostel.smallImagePublicIds[i] : '')).values.toList();
  }

  Future<void> submitUpdateForm(BuildContext context, GlobalKey<FormState> formKey, HostelEntity hostel) async {
    final locationState = context.read<LocationCubit>().state;
    final errors = {
      'name': Validation.validateName(nameController.text),
      'contact': Validation.validatePhone(contactNumberController.text),
      'description': Validation.validateDescription(descriptionController.text),
      'facilities': _facilities.isEmpty ? 'At least one facility is required' : null,
      'location': locationState is LocationLoaded ? null : 'Location is required',
    };

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
      final uploadSuccess = await uploadImages(context);
      if (uploadSuccess) {
        final updatedHostel = HostelEntity(
          id: hostel.id,
          name: nameController.text,
          placeName: (locationState as LocationLoaded).placeName,
          latitude: locationState.position.latitude,
          longitude: locationState.position.longitude,
          contactNumber: contactNumberController.text,
          description: descriptionController.text,
          facilities: _facilities,
          rooms: _rooms,
          ownerId: hostel.ownerId,
          ownerName: hostel.ownerName,
          mainImageUrl: _mainImageUrl,
          mainImagePublicId: _mainImagePublicId,
          smallImageUrls: _smallImageUrls,
          smallImagePublicIds: _smallImagePublicIds,
          createdAt: hostel.createdAt,
          status: hostel.status,
        );

        context.read<UpdateHostelBloc>().add(UpdateHostelSubmitEvent(updatedHostel));
      } else {
        context.read<UpdateHostelBloc>().add(UpdateHostelSubmitEvent(hostel)); // Revert to original on error
      }
    } else {
      context.read<UpdateHostelBloc>().add(UpdateHostelSubmitEvent(hostel)); // Revert to original on validation failure
    }
  }

  void dispose() {
    facilityController.dispose();
    nameController.dispose();
    contactNumberController.dispose();
    descriptionController.dispose();
  }
}