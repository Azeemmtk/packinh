import 'dart:io';
import 'package:flutter/material.dart';
import 'package:packinh/core/constants/colors.dart';
import 'package:packinh/core/constants/const.dart';
import 'package:packinh/core/widgets/title_text_widget.dart';
import 'package:packinh/core/services/image_picker_service.dart';

class ImageSection extends StatefulWidget {
  final ValueChanged<File?>? onMainImageChanged;
  final ValueChanged<List<File?>>? onSmallImagesChanged;
  final String? initialMainImageUrl;
  final List<String> initialSmallImageUrls;

  const ImageSection({
    super.key,
    this.onMainImageChanged,
    this.onSmallImagesChanged,
    this.initialMainImageUrl,
    this.initialSmallImageUrls = const [],
  });

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  File? _mainImage;
  final List<File?> _smallImages = [null, null, null];
  final ImagePickerService _imagePickerService = ImagePickerService();
  String? _mainImageUrl;
  List<String> _smallImageUrls = ['', '', ''];

  @override
  void initState() {
    super.initState();
    _mainImageUrl = widget.initialMainImageUrl;
    _smallImageUrls = widget.initialSmallImageUrls.length > 3
        ? widget.initialSmallImageUrls.sublist(0, 3)
        : List<String>.filled(3, '').asMap().map((i, url) => MapEntry(i, i < widget.initialSmallImageUrls.length ? widget.initialSmallImageUrls[i] : '')).values.toList();
  }

  Future<void> _pickImage({required bool isMainImage, int? smallImageIndex}) async {
    final File? pickedImage = await _imagePickerService.showImageSourceDialog(context);
    if (pickedImage != null) {
      setState(() {
        if (isMainImage) {
          _mainImage = pickedImage;
          _mainImageUrl = null; // Clear URL since new image is selected
          widget.onMainImageChanged?.call(_mainImage);
        } else if (smallImageIndex != null) {
          _smallImages[smallImageIndex] = pickedImage;
          _smallImageUrls[smallImageIndex] = ''; // Clear URL for this index
          widget.onSmallImagesChanged?.call(_smallImages);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(title: 'Add Images'),
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
                  ? DecorationImage(image: FileImage(_mainImage!), fit: BoxFit.cover)
                  : _mainImageUrl != null && _mainImageUrl!.isNotEmpty
                  ? DecorationImage(image: NetworkImage(_mainImageUrl!), fit: BoxFit.cover)
                  : null,
            ),
            child: _mainImage == null && (_mainImageUrl == null || _mainImageUrl!.isEmpty)
                ? Center(child: Text('Add image', style: TextStyle(fontSize: 20, color: Colors.black54)))
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
                      ? DecorationImage(image: FileImage(_smallImages[index]!), fit: BoxFit.cover)
                      : _smallImageUrls[index].isNotEmpty
                      ? DecorationImage(image: NetworkImage(_smallImageUrls[index]), fit: BoxFit.cover)
                      : null,
                ),
                child: _smallImages[index] == null && _smallImageUrls[index].isEmpty
                    ? Center(child: Text('Add image', style: TextStyle(fontSize: 20, color: Colors.black54)))
                    : null,
              ),
            );
          }),
        ),
      ],
    );
  }
}