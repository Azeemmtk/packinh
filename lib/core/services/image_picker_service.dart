import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:packinh/core/constants/colors.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // Pick multiple images from the gallery
  Future<List<File>?> pickMultipleImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        // Limit to maximum 4 images
        return pickedFiles.take(4).map((file) => File(file.path)).toList();
      }
      return null;
    } catch (e) {
      print('Error picking images: $e');
      return null;
    }
  }

  // Pick an image from the camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
      return null;
    } catch (e) {
      print('Error picking image from camera: $e');
      return null;
    }
  }

  // Show a bottom sheet to choose between camera and gallery
  Future<List<File>?> showImageSourceDialog(BuildContext context) async {
    return await showModalBottomSheet<List<File>?>(
      backgroundColor: mainColor,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text('Gallery', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  final images = await pickMultipleImages();
                  Navigator.of(context).pop(images);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text('Camera', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  final image = await pickImageFromCamera();
                  Navigator.of(context).pop(image != null ? [image] : null);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}