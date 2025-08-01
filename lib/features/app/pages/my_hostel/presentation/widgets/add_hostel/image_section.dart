import 'dart:io';
import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/core/services/image_picker_service.dart';

class ImageSection extends StatefulWidget {
  final ValueChanged<File?>? onMainImageChanged; // Callback for main image
  final ValueChanged<List<File?>>? onSmallImagesChanged; // Callback for small images

  const ImageSection({
    super.key,
    this.onMainImageChanged,
    this.onSmallImagesChanged,
  });

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  File? _mainImage;
  final List<File?> _smallImages = [null, null, null]; // Three slots for small images
  final ImagePickerService _imagePickerService = ImagePickerService();

  // Function to pick and set an image
  Future<void> _pickImage({required bool isMainImage, int? smallImageIndex}) async {
    final File? pickedImage = await _imagePickerService.showImageSourceDialog(context);
    if (pickedImage != null) {
      setState(() {
        if (isMainImage) {
          _mainImage = pickedImage;
          widget.onMainImageChanged?.call(_mainImage); // Notify parent of main image change
        } else if (smallImageIndex != null) {
          _smallImages[smallImageIndex] = pickedImage;
          widget.onSmallImagesChanged?.call(_smallImages); // Notify parent of small images change
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(
          title: 'Add Images',
        ),
        height20,
        GestureDetector(
          onTap: () => _pickImage(isMainImage: true),
          child: Container(
            width: double.infinity,
            height: height * 0.20,
            decoration: BoxDecoration(
              color: textFieldColor,
              borderRadius: BorderRadius.circular(15),
              image: _mainImage != null
                  ? DecorationImage(
                image: FileImage(_mainImage!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: _mainImage == null
                ? Center(
              child: Text(
                'Add image',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              ),
            )
                : null,
          ),
        ),
        height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () => _pickImage(isMainImage: false, smallImageIndex: index),
              child: Container(
                width: width * 0.3 - 3,
                height: height * 0.12,
                decoration: BoxDecoration(
                  color: textFieldColor,
                  borderRadius: BorderRadius.circular(15),
                  image: _smallImages[index] != null
                      ? DecorationImage(
                    image: FileImage(_smallImages[index]!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: _smallImages[index] == null
                    ? Center(
                  child: Text(
                    'Add image',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  ),
                )
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}