import 'dart:io';

import 'package:packinh/core/error/exceptions.dart';
import 'package:packinh/core/services/cloudinary_services.dart';

abstract class CloudinaryDataSource {
  Future<List<Map<String, String>>> uploadImage(List<File?> images);
}

class CloudinaryDataSourceImpl implements CloudinaryDataSource {
  final CloudinaryService cloudinaryService;

  CloudinaryDataSourceImpl(this.cloudinaryService);

  @override
  Future<List<Map<String, String>>> uploadImage(List<File?> images) async {
    try {
      return await cloudinaryService.uploadImage(images);
    } catch (e) {
      throw ServerException('Failed to upload image $e');
    }
  }
}
